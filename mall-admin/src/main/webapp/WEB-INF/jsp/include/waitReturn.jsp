<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>待退货订单管理</title>
</head>
<body>
<%--轮播图信息列表--%>
<table id="waitReturn_grid" class="easyui-datagrid" title="待退货订单列表"
       data-options="singleSelect:false,collapsible:true,toolbar:toolbarWaitReturn">
    <thead>
    <tr>
        <th data-options="field:'ck',checkbox:true"></th>
        <th data-options="field:'orderId',width:200">订单号</th>
        <th data-options="field:'productName',width:250,align:'right',formatter:  productFormatter
			">商品名称</th>
        <th data-options="field:'productNum',width:100,align:'right'">商品数量</th>
        <th data-options="field:'userId',width:130,align:'right'">用户ID</th>
        <th data-options="field:'userName',width:180,align:'right'">用户名</th>
        <th data-options="field:'status',width:120,align:'right'">订单状态</th>
    </tr>
    </thead>
</table>
<!-- 分页栏 -->
<div id="waitReturn_pagination" class="easyui-pagination">
</div>
<script>

    /**
     * 商品名链接
     */
    function productFormatter(value,row,index) {
        return "<a href='http://localhost:8080/mall/product?pid=" + row.productId + "' target='_blank'>"+value+"</a>"
    }


    /**
     * 初始化
     */
    (function () {
        waitReturnGrid()
    })()

    /**
     * 加载数据网格
     */
    function waitReturnGrid() {
        $.ajax({
            url: '${pageContext.request.contextPath}/order/waitReturnList.json',
            method: 'get',
            success: function (data) {
//                console.log(data)
                refreshPage(data, 1)
            }
        })
    }


    //获得被选中的行id
    function getSelectionsIds() {
        var sels = $("#waitReturn_grid").datagrid("getSelections");
        var ids = [];
        for (var i in sels) {
            ids.push(sels[i].orderId);
        }
        return ids;
    }

    /**
     * 工具栏
     * @type {[null,null]}
     */
    var toolbarWaitReturn = [{
        text: '允许退货',
        iconCls: 'icon-ok',
        handler: function () {
            var ids = getSelectionsIds();
            if (ids.length == 0) {
                $.messager.alert('提示', '请选择至少一行！');
                return
            }
            $.messager.confirm('确认', '确定允许订单号为' + ids + '的订单退货吗？', function (r) {
                if (r) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/order/goToReturn.json',
                        method: 'post',
                        data: {
                            'ids': ids
                        },
                        success: function (data) {
//                            console.log(data)
                            if (data.result === 'success') {
                                $.messager.alert('提示', '处理成功!', undefined, function () {
                                    var pageSize = $('#waitReturn_pagination').pagination('options').pageSize
                                    var pageNumber = $('#waitReturn_pagination').pagination('options').pageNumber
                                     if ($('#waitReturn_grid').datagrid('getRows').length == ids.length && pageNumber != 1) {
                                        pageNumber--
                                    }
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/order/waitReturnList.json?page=' + pageNumber + "&size=" + pageSize,
                                        method: 'get',
                                        success: function (data) {
                                            refreshPage(data, pageNumber)
                                        }
                                    })
                                    //删除处理后的行
                                    /*var sels = $("#waitReturn_grid").datagrid("getSelections");
                                    for (var index in sels) {
                                        var row_index = $("#waitReturn_grid").datagrid("getRowIndex", sels[index])
                                        $("#waitReturn_grid").datagrid('deleteRow', row_index);
                                    }*/
                                })
                            }
                        }
                    })
                }
            })
        }
    }]


    <%--分页功能实现--%>
    $('#waitReturn_pagination').pagination({
        onSelectPage: function (pageNumber, pageSize) {
            $(this).pagination('loading');
            // alert('pageNumber:' + pageNumber + ',pageSize:' + pageSize);
            $.ajax({
                url: '${pageContext.request.contextPath}/order/waitReturnList.json?page=' + pageNumber + "&size=" + pageSize,
                method: 'get',
                success: function (data) {
                    refreshPage(data, pageNumber)
                }
            })
            $(this).pagination('loaded');
        }
    });

    /**
     * 刷新列表
     */
    function refreshPage(data, pageNumber) {
        var arr = []
        for (var i = 0; i < data.adminOrderVoList.length; i++) {
            arr.push({
                productId: data.adminOrderVoList[i].productVo.product.id,
                productName: data.adminOrderVoList[i].productVo.product.name,
                userName: data.adminOrderVoList[i].user.username,
                userId: data.adminOrderVoList[i].user.id,
                orderId: data.adminOrderVoList[i].order.identifier,
                productNum: data.adminOrderVoList[i].order.productNum,
                status: "待退货"
            })
        }
//                console.log(arr)
        $('#waitReturn_grid').datagrid('loadData', arr)
        changePage(pageNumber, data.count)
    }

    /**
     * 分页设置每页显示条数和当前目录及其子目录共有多少件商品
     * */
    function changePage(page, total) {
        $('#waitReturn_pagination').pagination({
            total: total,
            pageNumber: page
        });
    }

</script>