$(function () {

  'use strict';

  var pieOptions     = {
    // Boolean - Whether we should show a stroke on each segment
    segmentShowStroke    : true,
    // String - The colour of each segment stroke
    segmentStrokeColor   : '#fff',
    // Number - The width of each segment stroke
    segmentStrokeWidth   : 1,
    // Number - The percentage of the chart that we cut out of the middle
    percentageInnerCutout: 50, // This is 0 for Pie charts
    // Number - Amount of animation steps
    animationSteps       : 100,
    // String - Animation easing effect
    animationEasing      : 'easeOutBounce',
    // Boolean - Whether we animate the rotation of the Doughnut
    animateRotate        : true,
    // Boolean - Whether we animate scaling the Doughnut from the centre
    animateScale         : false,
    // Boolean - whether to make the chart responsive to window resizing
    responsive           : true,
    // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
    maintainAspectRatio  : false,
    // String - A legend template
    legendTemplate       : '<ul class=\'<%=name.toLowerCase()%>-legend\'><% for (var i=0; i<segments.length; i++){%><li><span style=\'background-color:<%=segments[i].fillColor%>\'></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>',
    // String - A tooltip template
    tooltipTemplate      : '<%=value %> <%=label%> Transactions'
  };


  var pieChartCanvas = $('#txnShare').get(0).getContext('2d');
  var pieChart       = new Chart(pieChartCanvas);
  
  var PieData        = [{
      value    : $('#dataTxnShare #Credit').text(),
      color    : '#f56954',
      highlight: '#f56954',
      label    : 'Credit'
    },
    {
      value    : $('#dataTxnShare #Debit').text(),
      color    : '#00a65a',
      highlight: '#00a65a',
      label    : 'Debit'
    },
    {
      value    : $('#dataTxnShare #CashPOS').text(),
      color    : '#f39c12',
      highlight: '#f39c12',
      label    : 'Cash@POS'
    },
    {
      value    : $('#dataTxnShare #DMT').text(),
      color    : '#00c0ef',
      highlight: '#00c0ef',
      label    : 'DMT'
    },
    {
      value    : $('#dataTxnShare #Recharges').text(),
      color    : '#3c8dbc',
      highlight: '#3c8dbc',
      label    : 'Recharges'
    },
    {
      value    : $('#dataTxnShare #AEPS').text(),
      color    : '#d2d6de',
      highlight: '#d2d6de',
      label    : 'AEPS'
    }];
  
  // Create pie or douhnut chart
  // You can switch between pie and douhnut using the method below.
  pieChart.Doughnut(PieData, pieOptions);
  // -----------------
  // - END PIE CHART -
  // -----------------

  var pieChartCanvas = $('#deviceShare').get(0).getContext('2d');
  var pieChart       = new Chart(pieChartCanvas);
  var PieData        = [
    {
      value    : $('#dataDeviceShare #D200').text(),
      color    : '#39cccc',
      highlight: '#39cccc',
      label    : 'd200'
    },
    {
      value    : $('#dataDeviceShare #P500').text(),
      color    : '#d81b60',
      highlight: '#d81b60',
      label    : 'P500'
    },
    {
      value    : $('#dataDeviceShare #P1000').text(),
      color    : '#605ca8',
      highlight: '#605ca8',
      label    : 'P1000'
    },
    {
      value    : $('#dataDeviceShare #WizarPOS').text(),
      color    : '#d2d6de',
      highlight: '#d2d6de',
      label    : 'WizarPOS'
    },
    {
      value    : $('#dataDeviceShare #ME51').text(),
      color    : '#00a65a',
      highlight: '#00a65a',
      label    : 'ME51'
    }
  ];
  var pieOptions     = {
    // Boolean - Whether we should show a stroke on each segment
    segmentShowStroke    : true,
    // String - The colour of each segment stroke
    segmentStrokeColor   : '#fff',
    // Number - The width of each segment stroke
    segmentStrokeWidth   : 1,
    // Number - The percentage of the chart that we cut out of the middle
    percentageInnerCutout: 50, // This is 0 for Pie charts
    // Number - Amount of animation steps
    animationSteps       : 100,
    // String - Animation easing effect
    animationEasing      : 'easeOutBounce',
    // Boolean - Whether we animate the rotation of the Doughnut
    animateRotate        : true,
    // Boolean - Whether we animate scaling the Doughnut from the centre
    animateScale         : false,
    // Boolean - whether to make the chart responsive to window resizing
    responsive           : true,
    // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
    maintainAspectRatio  : false,
    // String - A legend template
    legendTemplate       : '<ul class=\'<%=name.toLowerCase()%>-legend\'><% for (var i=0; i<segments.length; i++){%><li><span style=\'background-color:<%=segments[i].fillColor%>\'></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>',
    // String - A tooltip template
    tooltipTemplate      : '<%=value %> <%=label%> users'
  };
  // Create pie or douhnut chart
  // You can switch between pie and douhnut using the method below.
  pieChart.Doughnut(PieData, pieOptions);
  // -----------------
  // - END PIE CHART -
  // -----------------

  var pieChartCanvas = $('#interchangeShare').get(0).getContext('2d');
  var pieChart       = new Chart(pieChartCanvas);
  var PieData        = [
    {
      value    : $('#dataInterchangeShare #Visa').text(),
      color    : '#f56954',
      highlight: '#f56954',
      label    : 'Visa'
    },
    {
      value    : $('#dataInterchangeShare #Master').text(),
      color    : '#3d9970',
      highlight: '#3d9970',
      label    : 'Master'
    },
    {
      value    : $('#dataInterchangeShare #Rupay').text(),
      color    : '#f39c12',
      highlight: '#f39c12',
      label    : 'Rupay'
    }
  ];
  var pieOptions     = {
    // Boolean - Whether we should show a stroke on each segment
    segmentShowStroke    : true,
    // String - The colour of each segment stroke
    segmentStrokeColor   : '#fff',
    // Number - The width of each segment stroke
    segmentStrokeWidth   : 1,
    // Number - The percentage of the chart that we cut out of the middle
    percentageInnerCutout: 50, // This is 0 for Pie charts
    // Number - Amount of animation steps
    animationSteps       : 100,
    // String - Animation easing effect
    animationEasing      : 'easeOutBounce',
    // Boolean - Whether we animate the rotation of the Doughnut
    animateRotate        : true,
    // Boolean - Whether we animate scaling the Doughnut from the centre
    animateScale         : false,
    // Boolean - whether to make the chart responsive to window resizing
    responsive           : true,
    // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
    maintainAspectRatio  : false,
    // String - A legend template
    legendTemplate       : '<ul class=\'<%=name.toLowerCase()%>-legend\'><% for (var i=0; i<segments.length; i++){%><li><span style=\'background-color:<%=segments[i].fillColor%>\'></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>',
    // String - A tooltip template
    tooltipTemplate      : '<%=value %> <%=label%> Routings'
  };
  // Create pie or douhnut chart
  // You can switch between pie and douhnut using the method below.
  pieChart.Doughnut(PieData, pieOptions);
  // -----------------
  // - END PIE CHART -
  // -----------------
});
