
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<div class="confirmPayPageDiv">
	<div class="confirmPayImageDiv">
		<img src="${pageContext.request.contextPath}/static/img/site/comformPayFlow.png">
		<div  class="confirmPayTime1">
			<fmt:formatDate value="${orderVo.order.createAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</div>
		<div  class="confirmPayTime2">
			<fmt:formatDate value="${orderVo.order.payAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</div>
		<div class="confirmPayTime3">
            <fmt:formatDate value="${orderVo.order.deliverAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</div>


	</div>
	<div class="confirmPayOrderInfoDiv">
		<div class="confirmPayOrderInfoText">我已收到货，同意支付宝付款</div>
	</div>
	<div class="confirmPayOrderItemDiv">
		<div class="confirmPayOrderItemText">订单信息</div>
		<table class="confirmPayOrderItemTable">
			<thead>
				<th colspan="2">宝贝</th>
				<th width="120px">原价</th>
				<th width="120px">促销价</th>
				<th width="120px">数量 </th>
				<th width="120px">运费</th>
			</thead>
			<%--<c:forEach items="${orderListVo.orderProductVos}" var="oi">--%>
				<tr>
					<td><img width="50px" src="${orderVo.productVo.firstImageUrl}"></td>
					<td class="confirmPayOrderItemProductLink">
						<a href="${pageContext.request.contextPath}/product?pid=${orderVo.productVo.product.id}">${orderVo.productVo.product.name}</a>
					</td>
					<td>￥<fmt:formatNumber type="number" value="${orderVo.productVo.product.price}" minFractionDigits="2"/></td>
					<td><span class="conformPayProductPrice">￥<fmt:formatNumber type="number" value="${orderVo.productVo.product.discount}" minFractionDigits="2"/></span></td>
					<td><span>${orderVo.order.productNum}</span></td>
					<td><span>快递 ： 0.00 </span></td>
				</tr>
			<%--</c:forEach>--%>
		</table>

		<div class="confirmPayOrderItemText pull-right">
			实付款： <span class="confirmPayOrderItemSumPrice">￥<fmt:formatNumber type="number" value="${orderVo.order.totalPrice}" minFractionDigits="2"/></span>
		</div>


	</div>
	<div class="confirmPayOrderDetailDiv">

		<table class="confirmPayOrderDetailTable">
			<tr>
				<td>订单编号：</td>
				<td>${orderVo.order.identifier} </td>
				<%--<td>${orderListVo.order.identifier} <img width="23px" src="img/site/confirmOrderTmall.png"></td>--%>
			</tr>
			<%--<tr>
				<td>卖家昵称：</td>
				<td>天猫商铺 <span class="confirmPayOrderDetailWangWangGif"></span></td>
			</tr>--%>
			<tr>
				<td >收货地址： </td>
				<td>${orderAddress.deliveryAddress}</td>
			</tr>
            <tr>
                <td>收货人姓名： </td>
                <td>
                ${orderAddress.deliveryName}
                </td>
            </tr>
            <tr>
                <td>收货人电话： </td>
                <td>
                ${orderAddress.phone}
                </td>
            </tr>
            <tr>
                <td>收货地址邮编： </td>
                <td>
                ${orderAddress.postalCode}
                </td>
            </tr>
			<tr>
				<td>成交时间：</td>
				<td><fmt:formatDate value="${orderVo.order.createAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</table>

	</div>
	<div class="confirmPayButtonDiv">
		<div class="confirmPayWarning">请收到货后，再确认收货！否则您可能钱货两空！</div>
		<a href="${pageContext.request.contextPath}/order/confiredPage?oid=${orderVo.order.id}"><button class="confirmPayButton">确认支付</button></a>
	</div>
</div>