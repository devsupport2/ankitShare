<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Manage Design of The Week</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon"
	href="<%=request.getContextPath()%>/resources/front/images/favicon.ico"
	type="image/png">

<link
	href="<%=request.getContextPath()%>/resources/admin/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="<%=request.getContextPath()%>/resources/admin/css/menustyle.css"
	rel="stylesheet" type="text/css" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/admin/js/angular.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/admin/js/controller/app.js"></script>

<!-- Date Picker Start -->
<link rel="stylesheet"
	href="https://kendo.cdn.telerik.com/2017.3.1026/styles/kendo.common-material.min.css" />
<link rel="stylesheet"
	href="https://kendo.cdn.telerik.com/2017.3.1026/styles/kendo.material.min.css" />
<link rel="stylesheet"
	href="https://kendo.cdn.telerik.com/2017.3.1026/styles/kendo.material.mobile.min.css" />
<!-- Date Picker Start -->

<script src="<%=request.getContextPath()%>/resources/admin/js/jquery.Jcrop.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/admin/css/jquery.Jcrop.css" type="text/css" />

<style>
/* For Firefox */
input[type='number'] {
	-moz-appearance: textfield;
}
/* Webkit browsers like Safari and Chrome */
input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>

</head>
<body ng-app="omessa" ng-controller="DesignWeekCtrl" ng-cloak>
	<%@include file="header.jsp"%>
	
	<div class="panel-body">
		<div class="container">
			<div class="row panel panel-primary"
				style="width: auto; background-color: #eee;">
				<div class="col-md-3">
					<h3 style="color: #db3615">Manage Design of The Week</h3>
				</div>
				<div class="col-md-5">
					<div class="input-group" style="margin-top: 15px">
						<input type="text" id="search" name="search" ng-model="search"
							class="form-control" placeholder="Search"
							ng-keyup="$event.keyCode == 13 ? searchDesignWeek() : null" /> <span
							class="input-group-btn">
							<button type="button" name="search" id="search-btn"
								ng-click="searchDesignWeek()" class="btn btn-flat"
								style="padding: 9px 12px;">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</div>
				<div class="col-md-1 text-right">
					<div class="form-group" style="margin-top: 15px">
						<select id="pageSize" name="pageSize" ng-model="pageSize"
							ng-options="item for item in pages" ng-change="changePage()"
							class="form-control" style="width: auto; display: inline;">
						</select>
					</div>
				</div>
				<div class="col-md-3 text-center">
					<div class="form-group" style="margin-top: 15px;">
						<a href="#" data-toggle="modal" data-target="#AddDesignWeek"
							class="btn btn-success btn-default"><i class="fa fa-plus"
							aria-hidden="true"></i> Add Design of The Week</a>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="table-responsive">
						<table id="mytable" class="table table-bordred table-striped">
							<thead>
								<th>From Date</th>
								<th>To Date</th>

								<th class="text-right"><i class="fa fa-trash"
									aria-hidden="true"></i></th>
							</thead>
							<tbody>
								<tr class="text-center" ng-if="getDesignWeeks == ''">									<td colspan="7"><span class="label label-default"RG@om765
										style="font-size: 15px;">Sorry... No data found.</span></td>
								</tr>
								<tr ng-repeat="item in getDesignWeeks"
									style="cursor: pointer; cursor: hand">
									<td title="Edit Record" ng-click="getDesignWeekById(item.designWeekID)" data-toggle="modal"
										data-target="#EditDesignWeek">{{item.fromDate}}</td>
									<td title="Edit Record"  ng-click="getDesignWeekById(item.designWeekID)" data-toggle="modal"
										data-target="#EditDesignWeek">{{item.toDate}}</td>

									<td title="Delete" class="text-right"><input
										type="checkbox" ng-model="item.selected"
										value="{{item.designWeekID}}"></td>
								</tr>
								<tr>
									<td colspan="7" class="text-right"><a href=""
										ng-click="deleteDesignWeek()" class="btn btn-danger"><i
											class="fa fa-trash" aria-hidden="true"></i></a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-5">
					<div class="hint-text">
						Showing <b>{{startindex+1}}-{{getDesignWeeks.length+startindex}}</b>
						out of <b>{{allcounts.DesignWeekCount}}</b> entries
					</div>
				</div>
				<div class="col-md-7">
					<button type="submit" class="btn btn-primary btn-default"
						ng-disabled="currentPage <= 0" ng-click="prev()">
						<i class="fa fa-step-backward"></i>
					</button>
					{{currentPage+1}}
					<button type="submit" class="btn btn-primary"
						ng-disabled="getDesignWeeks.length+startindex == allcounts.DesignWeekCount"
						ng-click="next()">
						<i class="fa fa-step-forward"></i>
					</button>
				</div>
			</div>
		</div>
	</div>


	<%@include file="footer.jsp"%>

	<div class="container">
		<div class="modal fade" id="AddDesignWeek" role="dialog" tabindex="-1">
			<div class="modal-dialog modal-lg">
			
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Manage Design of The Week</h4>
					</div>
					
					
					<div class="modal-body">
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label>From Date<font color="red" size="3">*</font></label> <input
										id="fromdateadd" class="KendoDate" style="width: 100%;">
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>To Date<font color="red" size="3">*</font></label> <input
										id="todateadd" class="KendoDate" style="width: 100%;">
								</div>
							</div>

						</div>
				
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label>Collection</label> <select name="collectionname"
										id="collectionname" ng-model="collectionname"
										ng-options="item.collectionId as item.collectionName for item in collections"
										ng-change="onCollectionChange(collectionname)"
										class="form-control">
										<option value="">---Collection---</option>
									</select>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>Category</label> <select name="categoryname"
										id="categoryname" ng-model="categoryname"
										ng-options="item.categoryId as item.categoryName for item in categoriesByCollection"
										ng-change="onCategoryChange(categoryname)"
										class="form-control">
										<option value="">---Category---</option>
									</select>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>Type</label> <select name="typename" id="typename"
										ng-model="typename"
										ng-options="item.typeId as item.typeName for item in types"
										ng-change="onTypeChange(typename)" class="form-control">
										<option value="">---Type---</option>
									</select>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>Product<font color="red" size="3">*</font></label> <select
										id="productname" name="productname" ng-model="productname"
										ng-change="onProductChange(productname)"
										ng-options="item.productId as item.productTitle+' ('+item.productCode+')' for item in getProducts"
										class="form-control">
										<option value="">--Product--</option>
									</select>
								</div>
							</div>

						</div>
						
						<div class="row" >
							<div class="col-md-12">
							<div class="table-responsive">
									<table id="mytable" class="table table-bordred table-striped">
										<thead>
											<th>Collection</th>
											<th>Category</th>
											<th>Type</th>
											<th>Product</th>

											<th class="text-right"><i class="fa fa-trash"
												aria-hidden="true"></i></th>
										</thead>
										<tbody>
											<tr ng-repeat="item in designList"
												style="cursor: pointer; cursor: hand">

												<td>{{item.collection}}</td>
												<td>{{item.category}}</td>
												<td>{{item.type}}</td>
												<td>{{item.productName}}</td>

												<td title="Delete" class="text-right"><a href=""
													ng-click="deleteDesignList(item)" class="btn btn-danger"><i
														class="fa fa-trash" aria-hidden="true"></i></a></td>
											</tr>

										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						<div class="row">
							<center>
								<div class="col-md-12">
									<button ng-click="addMoreDesign()" ng-disabled="spin == 1"
										class="btn btn-success">
										<i class="fa fa-plus" aria-hidden="true" ng-if="spin == 0"></i>
										<i class="fa fa-refresh fa-spin" ng-if="spin == 1"></i>Add
									</button>
								</div>
							</center>
						</div>
						
						
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-heading" style="background-color: #C0C0C0;">
										<h4>Product Images</h4>
									</div>
									<div class="panel-body" style=" background-color: #e0e0e0;">
									
									<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label> title</label> 
									<input id="p_title" name="p_title" ng-model="p_title" type="text" class="form-control" placeholder="Design image title" maxlength="50">
								</div>
							</div>
						<div class="col-md-1">
							<div class="form-group">
								<label>Sequence</label> <input type="text" class="form-control"	id="sequence_i" name="sequence_i" ng-model="sequence_i" maxlength="3">
							</div>
						</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>description</label> 
									<input id="p_desc" name="p_desc"
											ng-model="p_desc" type="text" class="form-control"
											placeholder="description image" maxlength="50"/>
								</div>
							</div>
						
						
  
       <!--         image            -->
 
 
             		<div class="col-md-3">
							<div class="form-group">
								<label>file Image</label>
								<input type="file" class="form-control" id="productImage" name="productImage" ng-model="productImage">
							</div>
					</div>
					
					<div class="col-md-2">
				<br>
					<button ng-click="addImage()" ng-disabled="spin == 1"
						class="btn btn-success">
						<i class="fa fa-plus" aria-hidden="true" ng-if="spin == 0"></i>
						<i class="fa fa-refresh fa-spin" ng-if="spin == 1"></i>Add
					</button>
				</div>
				
			</div>
			
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div align="center">
						<img src="#" id="target" />
					</div>
				
					<form name="myForm" class="ng-pristine ng-valid">
						<input hidden type="text" name="x" id="valuex" ng-model="valuex" />
						<input hidden type="text" name="y" id="valuey" ng-model="valuey" />
						<input hidden type="text" name="w" id="valuew" ng-model="valuew" />
						<input hidden type="text" name="h" id="valueh" ng-model="valueh" />
					</form>
				</div>
			</div>
			
					<div class="row">
							<div class="col-md-12">
								<div class="table-responsive">
									<table id="mytable" class="table table-bordred table-striped">
										<thead>
											<th>title</th>
											<th>sequence</th>
											<th>description</th>
											<th class="text-right"><i class="fa fa-trash"
												aria-hidden="true"></i></th>
										</thead>
										<tbody>

											<tr ng-repeat="item in designImageList1"
												style="cursor: pointer;">

												<td>{{item.p_title}}</td>
												<td>{{item.sequence_i}}</td>
												<td>{{item.p_desc}}</td>
												<td title="Delete" class="text-right"><a href=""
													ng-click="deleteDesignImageList(item)" class="btn btn-danger"><i
														class="fa fa-trash" aria-hidden="true"></i></a></td>
											</tr>

										</tbody>
									</table>
								</div>
							</div>
						</div>
									
									</div>
								</div>
								

							</div>
						</div>
						
						<!-- <div class="row" >
							<div class="col-md-12">
							<div class="row" >
								<div class="col-md-3">Collection</div>
								<div class="col-md-3">Category</div>
								<div class="col-md-3">Type</div>
								<div class="col-md-2">Product</div>
								<div class="col-md-1"><i class="fa fa-trash" aria-hidden="true"></i></div>
							</div>
							<div ng-repeat="item in designList">
								<hr>
								<hr>
								<div class="row">
									<div class="col-md-3">{{item.collection}}</div>
									<div class="col-md-3">{{item.category}}</div>
									<div class="col-md-3">{{item.type}}</div>
									<div class="col-md-2">{{item.productName}}</div>
									<div class="col-md-1"><a href="" ng-click="deleteDesignList(item)" class="btn btn-danger"><i
														class="fa fa-trash" aria-hidden="true"></i></a></div>
								</div>
								<hr>
								<div class="row" ng-repeat="items in designImageList1" ng-show="items.product_id == item.product">
									<div class="col-md-3">{{items.p_title}}</div>
									<div class="col-md-3">{{items.sequence_i}}</div>
									<div class="col-md-3">{{items.p_desc}}</div>
									<div class="col-md-2">{{items.file}}</div>
									<div class="col-md-1"><a href=""
													ng-click="deleteDesignList2(items)" class="btn btn-danger"><i
														class="fa fa-trash" aria-hidden="true"></i></a></div>
									<hr>
								</div>
							</div>
							</div>
						</div> -->
						
					</div>	
					<div class="modal-footer">
						<button type="submit" class="btn btn-success" ng-click="addDesignWeek()">Submit
								<i class="fa fa-plus" aria-hidden="true" ng-if="spin == 0"></i>
								<i class="fa fa-refresh fa-spin" ng-if="spin == 1"></i>
							</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				
						</div>
					</div>
				</div>
			</div>
	</div>

						
			
	<!-- update modal start -->

	
	<div class="container">
		<div class="modal fade" id="EditDesignWeek" role="dialog" tabindex="-1">
			<div class="modal-dialog modal-lg">
			
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Update Design of The Week</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label>From Date<font color="red" size="3">*</font></label> <input
										id="fromdate" class="KendoDate" style="width: 100%;">
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>To Date<font color="red" size="3">*</font></label> <input
										id="todate" class="KendoDate" style="width: 100%;">
								</div>
							</div>

						</div>
				
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label>Collection</label> <select name="collectionname"
										id="collectionnameupdate" ng-model="collectionname"
										ng-options="item.collectionId as item.collectionName for item in collections"
										ng-change="onCollectionChange(collectionname)"
										class="form-control">
										<option value="">---Collection---</option>
									</select>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>Category</label> <select name="categoryname"
										id="categorynameupdate" ng-model="categoryname"
										ng-options="item.categoryId as item.categoryName for item in categoriesByCollection"
										ng-change="onCategoryChange(categoryname)"
										class="form-control">
										<option value="">---Category---</option>
									</select>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>Type</label> <select name="typename" id="typename"
										ng-model="typename"
										ng-options="item.typeId as item.typeName for item in types"
										ng-change="onTypeChange(typename)" class="form-control">
										<option value="">---Type---</option>
									</select>
								</div>
								</div>
						<div class="col-md-3">
								<div class="form-group">
									<label>Product<font color="red" size="3">*</font></label> <select
										id="productname" name="productname" ng-model="productname"
										ng-options="item.productId as item.productTitle+' ('+item.productCode+')' for item in getProducts"
										class="form-control">
										<option value="">--Product--</option>
									</select>
								</div>
							</div>
						
						</div>
						
						
						<div class="row">
							<center>
								<div class="col-md-12">
									<button ng-click="editAddMoreDesign()" ng-disabled="spin == 1"
										class="btn btn-success">
										<i class="fa fa-plus" aria-hidden="true" ng-if="spin == 0"></i>
										<i class="fa fa-refresh fa-spin" ng-if="spin == 1"></i>Add
									</button>
								</div>
							</center>
						</div>
						
						<div class="row" >
							<div class="col-md-12">
							<div class="table-responsive">
									<table id="mytable" class="table table-bordred table-striped">
										<thead>
											<th>Collection</th>
											<th>Category</th>
											<th>Type</th>
											<th>Product</th>

											<th class="text-right"><i class="fa fa-trash"
												aria-hidden="true"></i></th>
										</thead>
										<tbody>

											<tr ng-repeat="item in designListUpdate"
												style="cursor: pointer; cursor: hand">

												<td>{{item.collection_name}}</td>
												<td>{{item.category_name}}</td>
												<td>{{item.type_name}}</td>
												<td>{{item.product_title}}({{item.product_code}})</td>

												<td title="Delete" class="text-right"><a href=""
													ng-click="editDeleteDesignList(item.design_week_collection_id)" class="btn btn-danger"><i
														class="fa fa-trash" aria-hidden="true"></i></a></td>
											</tr>

										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-heading" style="background-color: #C0C0C0;">
										<h4>Extra Images</h4>
									</div>
									<div class="panel-body" style=" background-color: #e0e0e0;">
									
									<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label> title</label> 
									<input id="p_titleEdit" name="p_titleEdit" ng-model="p_titleEdit" type="text" class="form-control" placeholder="design image Title" maxlength="50">
								</div>
							</div>
						<div class="col-md-1">
							<div class="form-group">
								<label>Sequence</label> <input type="text" class="form-control"	id="sequence_iEdit" name="sequence_iEdit" ng-model="sequence_iEdit" maxlength="10">
							</div>
						</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>description</label> 
									<input id="p_descEdit" name="p_descEdit" ng-model="p_descEdit" type="text" class="form-control" placeholder="description image" maxlength="50">
								</div>
							</div>
						
						
  
       <!--         image            -->
 
 
		             	<div class="col-md-3">
							<div class="form-group">
								<label>file Image</label>
								<input type="file" class="form-control" id="productImage1" name="productImage1" ng-model="productImage1">
							</div>
						</div>
				
				<div class="col-md-2">
				<br>
					<button ng-click="addImage2()" ng-disabled="spin == 1"
						class="btn btn-success">
						<i class="fa fa-plus" aria-hidden="true" ng-if="spin == 0"></i>
						<i class="fa fa-refresh fa-spin" ng-if="spin == 1"></i>Add
					</button>
				</div>
						
         <!--     end  -->
			</div>
			
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div align="center">
						<img src="#" id="targetupdate" />
					</div>
				
					<form name="myFormupdate" class="ng-pristine ng-valid">
						<input type="hidden" name="x1" id="valuex1" ng-model="valuex1" />
						<input type="hidden" name="y1" id="valuey1" ng-model="valuey1" />
						<input type="hidden" name="w1" id="valuew1" ng-model="valuew1" />
						<input type="hidden" name="h1" id="valueh1" ng-model="valueh1" />
					</form>
					
				</div>
			</div>
			
			<div class="row">
							<div class="col-md-12">
								<div class="table-responsive">
									<table id="mytable" class="table table-bordred table-striped">
										<thead>
											<th>title</th>
											<th>sequence</th>
											<th>description</th>
											<th>image</th>
											<th class="text-right"><i class="fa fa-trash"
												aria-hidden="true"></i></th>
										</thead>
										<tbody>

											<tr ng-repeat="item in designImageList2"
												style="cursor: pointer; cursor: hand">

												<td>{{item.p_title}}</td>
												<td>{{item.sequence_i}}</td>
												<td>{{item.p_desc}}</td>
												<td><img style="width:100px;" src="{{item.file}}"></td> 

												<td title="Delete" class="text-right"><a href=""
													ng-click="deleteDesignUpdateList(item.desigImage_id)" class="btn btn-danger"><i
														class="fa fa-trash" aria-hidden="true"></i></a></td>
											</tr>
											
												
										</tbody>
									</table>
								</div>
							</div>
						</div>
									
									</div>
								</div>
								
						
								
							</div>
						</div>
						<!-- <div class="row" >
							<div class="col-md-12">
							<div class="row" >
								<div class="col-md-3">Collection</div>
								<div class="col-md-3">Category</div>
								<div class="col-md-3">Type</div>
								<div class="col-md-2">Product</div>
								<div class="col-md-1"><i class="fa fa-trash" aria-hidden="true"></i></div>
							</div>
							<div ng-repeat="item in designListUpdate">
								<hr>
								<hr>
								<div class="row">
									<div class="col-md-3">{{item.collection_name}}</div>
									<div class="col-md-3">{{item.category_name}}</div>
									<div class="col-md-3">{{item.type_name}}</div>
									<div class="col-md-2">{{item.product_title}}({{item.product_code}})</div>
									<div class="col-md-1"><a href="" ng-click="editDeleteDesignList(item.design_week_collection_id)" class="btn btn-danger"><i
														class="fa fa-trash" aria-hidden="true"></i></a></div>
								</div>
								<hr>
								<div class="row" ng-repeat="items in designImageList2" ng-show="items.product_id == item.product_id">
									<div class="col-md-3">{{items.p_title}}</div>
									<div class="col-md-3">{{items.sequence_i}}</div>
									<div class="col-md-3">{{items.p_disc}}</div>
									<div class="col-md-2"><img src="{{items.file}}" style="height: 50px; width: 50px;"></div>
									<div class="col-md-1"><a href=""
													ng-click="deleteDesignUpdateList(item.desigImage_id)" class="btn btn-danger"><i
														class="fa fa-trash" aria-hidden="true"></i></a></div>
									<hr>
								</div>
							</div>
							</div>
						</div> -->
			
			
					</div>	

						
								
	
					<div class="modal-footer">
						<button type="submit" class="btn btn-success" ng-click="editDesignWeek()">UPDATE
								<i class="fa fa-plus" aria-hidden="true" ng-if="spin == 0"></i>
								<i class="fa fa-refresh fa-spin" ng-if="spin == 1"></i>
							</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				
						</div>
					</div>
				</div>
			</div>
	</div>


 <!----- update end    ---------------------------- -->
	
	
	<!-- Date Picker Start -->
	<script src="https://kendo.cdn.telerik.com/2017.3.1026/js/kendo.all.min.js"></script>
	
	<script>


	jQuery(function($) {
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					if ($('#target').data('Jcrop')) {
						$('#target').data('Jcrop').destroy();
						$('#target').removeAttr('style');
					}

					var u = URL.createObjectURL(input.files[0]);
					var img = new Image;
					img.onload = function() {
						if (img.width < 200 || img.height < 200) {
							alert("Minimum image size should be 200px W X 200px H");
							$('#target').attr('src', "");
							document.getElementById("productImage").value = null;
						} else {

							//$('#target').css("max-width", "500px");
							$('#target').css("min-height", "200px");

							$('#target').attr('src', e.target.result);
							$('#target').Jcrop({
								aspectRatio : 1 / 1,
								boxWidth : 500,
								boxHeight : 500,
								setSelect : [ 0, 0, 100, 100 ],
								onChange : setCoordinates,
								onSelect : setCoordinates,
								minSize : [ 100, 100 ],
								bgColor : ''
							});
						}
					};
					img.src = u;
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$("#productImage").change(function() {
			readURL(this);
		});
		$("#productImage").click(function() {
			this.value = null;
		});
	});
	function setCoordinates(c) {
		//alert("x " + c.x + " y " + c.y);
		//alert("w " + c.w + " h " + c.h);
		document.myForm.x.value = Math.round(c.x);
		document.myForm.y.value = Math.round(c.y);
		document.myForm.w.value = Math.round(c.w);
		document.myForm.h.value = Math.round(c.h);
	};
	function checkCoordinates() {
		if (document.myForm.x.value == "" || document.myForm.y.value == "") {
			alert("Please select a crop region");
			return false;
		} else {
			return true;
		}
	};

//for update product image

	jQuery(function($) {
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					if ($('#targetupdate').data('Jcrop')) {
						$('#targetupdate').data('Jcrop').destroy();
						$('#targetupdate').removeAttr('style');
					}

					var u = URL.createObjectURL(input.files[0]);
					var img = new Image;
					img.onload = function() {
						if (img.width < 200 || img.height < 200) {
							alert("Minimum image size should be 200px W X 200px H");
							$('#targetupdate').attr('src', "");
							document.getElementById("productImage1").value = null;
						} else {

							//$('#targetupdate').css("max-width", "500px");
							$('#target').css("min-height", "200px");

							$('#targetupdate').attr('src', e.target.result);
							$('#targetupdate').Jcrop({
								aspectRatio : 1 / 1,
								boxWidth : 500,
								boxHeight : 500,
								setSelect : [ 0, 0, 100, 100 ],
								onChange : setCoordinatesupdate,
								onSelect : setCoordinatesupdate,
								minSize : [ 100, 100 ],
								bgColor : ''
							});
						}
					};
					img.src = u;
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$("#productImage1").change(function() {
			readURL(this);
		});
		$("#productImage1").click(function() {
			this.value = null;
		});
	});
	function setCoordinatesupdate(c) {
		//alert("x " + c.x + " y " + c.y);
		//alert("w " + c.w + " h " + c.h);
		document.myFormupdate.x1.value = Math.round(c.x);
		document.myFormupdate.y1.value = Math.round(c.y);
		document.myFormupdate.w1.value = Math.round(c.w);
		document.myFormupdate.h1.value= Math.round(c.h);
	};
	function checkCoordinatesupdate() {
		if (document.myFormupdate.x1.value == "" || document.myFormupdate.y1.value == "") {
			alert("Please select a crop region");
			return false;
		} else {
			return true;
		}
	};
	
	</script>
		
	
	
	
	<script>
		$(document).ready(function() {
			$("#fromdateadd").kendoDatePicker({
				format : "dd/MM/yyyy",
				dateInput : true,
				value : new Date(),
				min : new Date()
			});
			$("#todateadd").kendoDatePicker({
				format : "dd/MM/yyyy",
				dateInput : true,
				value : new Date(),
				min : new Date()
			});
			$("#dateadd").kendoDatePicker({
				format : "dd/MM/yyyy",
				dateInput : true,
				min : new Date()
			//value: new Date(d.getFullYear(), d.getMonth(), 1)
			});

			$("#fromdate").kendoDatePicker({
				format : "dd/MM/yyyy",
				dateInput : true,
				value : new Date()
			});
			$("#todate").kendoDatePicker({
				format : "dd/MM/yyyy",
				dateInput : true,
				value : new Date()
			});
			$("#date").kendoDatePicker({
				format : "dd/MM/yyyy",
				dateInput : true,
			//value: new Date(d.getFullYear(), d.getMonth(), 1)
			});

		});
		$(".KendoDate").bind("focus", function() {
			$(this).data("kendoDatePicker").open();
		});
	</script>
	<!-- Date Picker End -->

</body>
</html>