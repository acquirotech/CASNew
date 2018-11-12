<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/jsp/head.jsp" />
<jsp:include page="/jsp/sidebar.jsp" />
<jsp:include page="/jsp/topbar.jsp" />
 
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

      <div class="row">
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3>150</h3>

              <p>New Transactions Today</p>
            </div>
            <div class="icon">
              <i class="ion ion-bag"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <h3>53<sup style="font-size: 20px">%</sup></h3>

              <p>Success Rate</p>
            </div>
            <div class="icon">
              <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>44</h3>

              <p>New Merchant Registrations</p>
            </div>
            <div class="icon">
              <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3>65<sup style="font-size: 20px">%</sup></h3>

              <p>Active Merchants</p>
            </div>
            <div class="icon">
              <i class="ion ion-pie-graph"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
      </div>



      <div class="row">

         <div class="col-md-4">
          <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Transaction Share</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body" style="">
              <div class="row">
                <div class="col-md-8">
                  <div class="chart-responsive">
                    <canvas id="txnShare" height="180" width="205" style="width: 205px; height: 180px;"></canvas>
                  </div>
                  <!-- ./chart-responsive -->
                </div>
                <!-- /.col -->
                <div class="col-md-4">
                  <ul class="chart-legend clearfix">
                    <li><i class="fa fa-circle-o text-red"></i> Credit Cards</li>
                    <li><i class="fa fa-circle-o text-green"></i> Debit Cards</li>
                    <li><i class="fa fa-circle-o text-yellow"></i> Cash@POS</li>
                    <li><i class="fa fa-circle-o text-aqua"></i> DMT</li>
                    <li><i class="fa fa-circle-o text-light-blue"></i> Recharges</li>
                    <li><i class="fa fa-circle-o text-gray"></i> AEPS</li>
                  </ul>
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.box-body -->
            <div class="box-footer no-padding" style="">
                         
            </div>
            <!-- /.footer -->
          </div>
        </div>

        <div class="col-md-4">
          <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Device Share</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body" style="">
              <div class="row">
                <div class="col-md-8">
                  <div class="chart-responsive">
                    <canvas id="deviceShare" height="180" width="205" style="width: 205px; height: 180px;"></canvas>
                  </div>
                  <!-- ./chart-responsive -->
                </div>
                <!-- /.col -->
                <div class="col-md-4">
                  <ul class="chart-legend clearfix">
                    <li><i class="fa fa-circle-o text-teal"></i> D200</li>
                    <li><i class="fa fa-circle-o text-maroon"></i> P500</li>
                    <li><i class="fa fa-circle-o text-purple"></i> P1000</li>
                    <li><i class="fa fa-circle-o text-gray"></i> WizarPOS</li>
                    <li><i class="fa fa-circle-o text-green"></i> ME51</li>
                  </ul>
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.box-body -->
            <div class="box-footer no-padding" style="">
              
            </div>
            <!-- /.footer -->
          </div>
        </div>

        <div class="col-md-4">
          <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Interchange Usage</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body" style="">
              <div class="row">
                <div class="col-md-8">
                  <div class="chart-responsive">
                    <canvas id="interchangeShare" height="180" width="205" style="width: 205px; height: 180px;"></canvas>
                  </div>
                  <!-- ./chart-responsive -->
                </div>
                <!-- /.col -->
                <div class="col-md-4">
                  <ul class="chart-legend clearfix">
                    <li><i class="fa fa-circle-o text-red"></i> Visa</li>
                    <li><i class="fa fa-circle-o text-olive"></i> Master</li>
                    <li><i class="fa fa-circle-o text-yellow"></i> Rupay</li>
                  </ul>
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.box-body -->
            <div class="box-footer no-padding" style="">
              
            </div>
            <!-- /.footer -->
          </div>
        </div>
      </div>

    </section>
    <!-- /.content -->
  </div>


<div id="dataTxnShare" style="display:none">
<span id="Credit">15</span>
<span id="Debit">20</span>
<span id="CashPOS">45</span>
<span id="DMT">21</span>
<span id="Recharges">10</span>
<span id="AEPS">5</span>
</div>

<div id="dataDeviceShare" style="display:none">
<span id="D200">6</span>
<span id="P500">7</span>
<span id="P1000">2</span>
<span id="WizarPOS">4</span>
<span id="ME51">9</span>
</div>

<div id="dataInterchangeShare" style="display:none">
<span id="Visa">665</span>
<span id="Master">280</span>
<span id="Rupay">467</span>
</div>
<jsp:include page="/jsp/footer.jsp" />
