<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课室管理系统</title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style type="text/css">
        td,th{
            text-align: center;
        }
    </style>
    <script  type="text/javascript">
        $(function () {
            getteacher();
            $("#delSelected").click(function () {
                confirm("确定删除？")
                var  flag=false;
                var Tids=document.getElementsByName("Tid");
                for (var i=0;i<Tids.length;i++){
                    if (Tids[i].checked){
                        flag=true;
                        break;
                    }
                }
                if (flag){
                    document.getElementById("form").submit();
                }
            })
            $("#firstCb").click(function () {
                var Tids=document.getElementsByName("Tid");
                for (var i=0;i<Tids.length;i++){
                    Tids[i].checked=this.checked;
                }
            })
            $("#checkcourse4").click(function () {
                var  Tage=$("input[id='Tage']").val();
                var Tname=$("#Tname>option:selected").val();
                $(document).ready(function paging(page){
                    $.ajax({
                        type: "GET",
                        url: "checkteacher2.do",
                        data:{Tname:Tname,Tage:Tage},
                        dataType:"json",
                        success: function(resp){
                            if (resp.code==0){
                                console.log(resp.data.length);
                                alert(resp.msg);
                                $("#teacherinfo").empty();
                                $.each(resp.data,function (i,n) {
                                    $("#teacherinfo").append(
                                        "<tr><td>" +
                                        "<input type='checkbox' name='Tid' value="+n.tid+"></td><td>" +
                                        ""+n.tid+"</td><td>" +
                                        "" +n.tname+"</td><td>" +
                                        "" +n.tage+"</td><td>" +
                                        "<a  class='btn btn-primary' href='${pageContext.request.contextPath}/checkteacher3.do?Tid="+n.tid+"'>修改</a></td></td>")
                                })
                            }
                            else {
                                alert(resp.msg);
                                $("#classroominfo").empty();
                            }
                            var a = document.getElementById("teacherinfo").getElementsByTagName("tr");
                            //alert(a.length);
                            var zz =new Array(a.length);
                            //alert(zz.length);
                            for(var i=0;i<a.length;i++)
                            { zz[i]=a[i].innerHTML } //div的字符串数组付给zz
                            var pageno=1;               //当前页
                            var pagesize=4;            //每页多少条信息
                            if(zz.length%pagesize==0)
                            {var  pageall =zz.length/pagesize }
                            else
                            {var  pageall =parseInt(zz.length/pagesize)+1}       //一共多少页
                            $("#p").text(pageall);      //将pageall的值存放到div中，便于下次使用
                            change(1,pageall,zz);
                        }
                    })
                })
            })
            $("#addteacher").on("click",function () {
                var  Tid=$("input[id='tid']").val();
                var  Tname=$("input[id='tname2']").val();
                var  Tage=$("input[id='tage2']").val();
                if (Tid==null||Tname==null||Tage==null||Tid==""||Tname==""||Tage==""){
                    alert("请输入全部相关信息！！")
                }else {
                    $.get("addteacher.do",{Tid:Tid,Tname:Tname,Tage:Tage},function (resp){
                        if (resp.code==0){
                            alert(resp.msg);
                        }else {
                            alert(resp.msg);
                        }
                    },"json")
                }


            })

        })
        var k;
        function change(e,all,zu){
            zz=zu;
            var pagesize=4;   //每页多少条信息
            pageall=all;     //总页数
            pageno=e;        //当前页
            if(e <1)//如果输入页<1页
            { e=1;pageno=1}//就等于第1页 ， 当前页为1
            if(e>pageall)//如果输入页大于最大页
            {e=pageall;pageno=pageall}//输入页和当前页都=最大页
            document.getElementById("teacherinfo").innerHTML="";//全部清空
            for(var i=0;i<pagesize;i++)
            {
                var div =document.createElement("tr");//建立div对象
                div.innerHTML=zz[(e-1)*pagesize+i];//建立显示元素
                document.getElementById("teacherinfo").appendChild(div);//加入tbody中
                if(zz[(e-1)*pagesize+i+1]==null)//超出范围跳出
                    break
            }
            var ye="";
            for(var j=1;j<=pageall;j++)
            {
                if(e==j)
                {ye=ye+"<a href='#' onClick='change1("+j+")' style='color:#FF0000'>"+j+"</a>"}
                else
                {ye=ye+"<a href='#' onClick='change1("+j+")'>"+j+"</a> "}
            }
            document.getElementById("a1").innerHTML=pageall;
            document.getElementById("a2").innerHTML=pageno;
            document.getElementById("a3").innerHTML=ye;
            /*如果当前是第一页则：*/
            if (pageno == 1)
            {
                $('#down').hide();//隐藏
            }else {
                $('#down').show();//显示
            }
            /*如果是最后一页则：*/
            if (pageno == pageall)
            {
                $('#up').hide();//隐藏
            }else {
                $('#up').show();//显示
            }
            k=zu;
        }
        function change1(e){
            zz=k;
            var pagesize=4;
            pageno=e;
            if(e <1)//如果输入页<1页
            { e=1;pageno=1}//就等于第1页 ， 当前页为1
            if(e>pageall)//如果输入页大于最大页
            {e=pageall;pageno=pageall}//输入页和当前页都=最大页
            document.getElementById("teacherinfo").innerHTML="";//全部清空
            for(var i=0;i<pagesize;i++)
            {
                var div =document.createElement("tr");//建立div对象
                div.innerHTML=zz[(e-1)*pagesize+i];//建立显示元素
                document.getElementById("teacherinfo").appendChild(div);//加入tbody中
                if(zz[(e-1)*pagesize+i+1]==null)//超出范围跳出
                    break
            }
            var ye="";
            for(var j=1;j<=pageall;j++)
            {
                if(e==j)
                {ye=ye+"<a href='#' onClick='change1("+j+")' style='color:#FF0000'>"+j+"</a> "}
                else
                {ye=ye+"<a href='#' onClick='change1("+j+")'>"+j+"</a> "}
            }
            document.getElementById("a1").innerHTML=pageall;
            document.getElementById("a2").innerHTML=pageno;
            document.getElementById("a3").innerHTML=ye;
            /*如果当前是第一页则：*/
            if (pageno == 1)
            {
                $('#down').hide();//隐藏
            }else {
                $('#down').show();//显示
            }

            /*如果是最后一页则：*/

            if (pageno == pageall)
            {
                $('#up').hide();//隐藏
            }else {
                $('#up').show();//显示
            }
        }
        function getteacher() {
            $.ajax({
                url: "checkteacher.do",
                dataType: "json",
                success: function (resp) {
                    $.each(resp.data, function (i, n) {
                        $("#Tname").append("<option value='"+n.tname+ "'>" +n.tname+"</option>")
                    })
                }
            })
        }
    </script>
</head>
<body>
<div class="container">
    <h3>教室信息管理</h3>
    <div style="float: left">
        <form class="form-inline" action="${pageContext.request.contextPath}/checkcourse4.do" method="post">

              <div class="form-group">
                <label for="Tname">老师名字</label>
                <select name="Tname" id="Tname" class="form-control">
                    <option value=""></option>
                </select>
            </div>

            <div class="form-group">
                <label for="Tage">年龄</label>
                <input type="text" class="form-control" id="Tage" name="Tage" value="${Tage[0]}">
            </div>
            <input type="button" id="checkcourse4"  class="btn btn-default" value="查询">
        </form>

    </div>
    <div style="float: right;margin: 5px" >
        <button class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="666">
            添加新老师信息
        </button>
        <a class="btn btn-primary" href="javascript:void(0);" id= "delSelected">删除老师信息</a>
    </div>
    <form id="form" action="${pageContext.request.contextPath}/delteacher.do" method="post">
   <div>
        <table border="1" class="table table-bordered table-hover">
            <tr class="success"  style="font-size: 13px">
                <th style="text-align: center" ><input type="checkbox" id="firstCb"></th>
                <th style="text-align: center">编号</th>
                <th style="text-align: center">名字</th>
                <th style="text-align: center">年龄</th>
                <th style="text-align: center">执行</th>
            </tr>
            <tbody class="success" style="font-size: 13px" id="teacherinfo">
            </tbody>
        </table>
       <div class="page">
           <ul class="pagination">
               <li> <a id="down" href="#" onClick="change1(--pageno)">上一页</a>　　</li>
               <li id="a3"></li>

               <li><a id="up" href="#" onClick="change1(++pageno)">下一页</a></li>

               <li>  <span class="ho">第<span id="a2"></span>/<span id="a1"></span>页</span> </li>
           </ul>
       </div>
       <!--用来存放总页数，放置在body中-->

   </div>
    </form>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    添加新新老师信息
                </h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="tid">编号</label>
                    <input type="text" class="form-control" id="tid" name="tid" value="${cid[0]}">
                </div>
                <div class="form-group">
                    <label for="tname2">教学名字</label>
                    <input type="text" class="form-control" id="tname2" name="tname" value="${house[0]}">
                </div>
                <div class="form-group">
                    <label for="tage2">年龄</label>
                    <input type="text" id="tage2" name="tage" class="form-control">
                </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="addteacher">
                    添加
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
    $(function () { $('#myModal').modal('hide')});
</script>
<script>
    $(function () { $('#myModal').on('hide.bs.modal', function () {
    })})
</script>
</div>

</body>
</html>

