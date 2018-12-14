
<aside class="main-sidebar">
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="resources/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p><%= session.getAttribute("userName") %></p>
          <a href="#"> Admin</a>
        </div>
      </div>

      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">MAIN NAVIGATION</li>
        
        <li>
          <a href="welcome">
            <i class="fa fa-dashboard"></i> <span>Home</span>
          </a>
        </li>

        <li class="treeview">
          <a href="#">
            <i class="fa fa-user-plus"></i> <span>Manage Employees</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
          	  <li><a href="addEmployee"><i class="fa fa-circle-o"></i>Add New Employee</a></li>
            <li><a href="emplockunlock"><i class="fa fa-circle-o"></i>Employee List</a></li>
          </ul>
        </li>

        <li class="treeview">
          <a href="#">
            <i class="fa fa-filter"></i> <span>Preboard Merchants</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="addPreBoardMerchant"><i class="fa fa-circle-o"></i>Preboard New Merchant</a></li>
            <li><a href="PreBoardedMerchantlist"><i class="fa fa-circle-o"></i>Preboard Merchant List</a></li>
          </ul>
        </li>

        <li class="treeview">
          <a href="#">
            <i class="fa fa-users"></i> <span>Manage Merchants</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="list"><i class="fa fa-circle-o"></i>Merchant List</a></li>
            <li><a href="addmerchant"><i class="fa fa-circle-o"></i>Add New Merchant</a></li>
            <li><a href="addOrg"><i class="fa fa-circle-o"></i>Add New Store</a></li>
            <li><a href="addDeviceDetail"><i class="fa fa-circle-o"></i>Add New Terminal</a></li>
          </ul>
        </li>
 		<li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i> <span>Call Support Management</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="createTeleCustomer"><i class="fa fa-circle-o"></i>Log Complaint</a></li>
            <li><a href="teleCustomerList"><i class="fa fa-circle-o"></i>Log Complaint List</a></li>
           </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i> <span>Transaction List</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="walletList"><i class="fa fa-circle-o"></i>Debit/Credit</a></li>
            <li><a href="rechargeList"><i class="fa fa-circle-o"></i>Recharges</a></li>
            <li><a href="transactionList"><i class="fa fa-circle-o"></i>DMT</a></li>
          </ul>
        </li>
<li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i> <span>Risk Transaction List</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="riskManagementList"><i class="fa fa-circle-o"></i>Risk Transaction List</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-pie-chart"></i>
            <span>Online Reports</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="cardTxnReport"><i class="fa fa-circle-o"></i> Transaction Report</a></li>
            <li><a href="cardCommissionReportProcedure"><i class="fa fa-circle-o"></i> Commission Report</a></li>
          </ul>
        </li>
          <li class="treeview">
          <a href="#">
            <i class="fa fa-list-ol"></i> <span>Card Prepaid Inventory</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="addPrepaidInventory"><i class="fa fa-circle-o"></i>Add New Card Prepaid</a></li>
            <li><a href="prepaidInventoryList"><i class="fa fa-circle-o"></i>Card Prepaid Inventory List</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-list-ol"></i> <span>Device Inventory</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="inventoryAddDevice"><i class="fa fa-circle-o"></i>Add New Inventory</a></li>
            <li><a href="inventoryList"><i class="fa fa-circle-o"></i>Inventory List</a></li>
          </ul>
        </li>
      <li class="treeview">
          <a href="#">
            <i class="fa fa-list-ol"></i> <span>DSA Management</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="addDSA"><i class="fa fa-circle-o"></i>Add New DSA</a></li>
            <li><a href="dsaManagement"><i class="fa fa-circle-o"></i>DSA List</a></li>
          </ul>
        </li>
        <li>
          <a href="settingHome">
            <i class="fa fa-gears"></i> <span>Settings</span>
          </a>
        </li>

      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
