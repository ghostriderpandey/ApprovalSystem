<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="AdminPanel_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #fb9ebe">
                <span class="count_top"><i class="fa fa-user"></i>Total Users</span>
                <div class="count">
                    <asp:Label ID="lblTotalUsers" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #abb1fc">
                <span class="count_top">Total Purchase Logic Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalPurchaseLogicNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #f7cfaf">
                <span class="count_top">Total Pending Purchase Logic Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalPendingPurchaseLogicNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #a1f5c0">
                <span class="count_top">Total Approved Purchase Logic Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalApprovedPurchaseLogicNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #9adef4">
                <span class="count_top">Total Purchase Amendment Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalPurchaseAmendmentNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #fb9ebe">
                <span class="count_top">Total Pending Purchase Amendment Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalPendingPurchaseAmendmentNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #abb1fc">
                <span class="count_top">Total Approved Purchase Amendment Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalApprovedPurchaseAmendmentNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #f7cfaf">
                <span class="count_top">Total Contract Logic Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalContractLogicNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #a1f5c0">
                <span class="count_top">Total Pending Contract Logic Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalPendingContractLogicNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #9adef4">
                <span class="count_top">Total Approved Contract Logic Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalApprovedContractLogicNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #fb9ebe">
                <span class="count_top">Total Contract Amendment Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalContractAmendmentNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #abb1fc">
                <span class="count_top">Total Pending Contract Amendment Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalPendingContractAmendmentNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-4  tile_stats_count">
            <div class="dashbordbox" style="background: #f7cfaf">
                <span class="count_top">Total Approved Contract Amendment Note</span>
                <div class="count">
                    <asp:Label ID="lblTotalApprovedContractAmendmentNote" Style="font-size: 40px;" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
    </div>

  <%--  <div class="row mt-3">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header " style="background: #f7cfaf">
                    <span class="h5 text-dark">Featured</span>
                </div>
                <div class="card-body" style="min-height: 300px"></div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header" style="background: #a1f5c0">
                    <span class="h5 text-dark">Featured</span>
                </div>
                <div class="card-body" style="min-height: 300px"></div>
            </div>
        </div>

    </div>--%>
    <%-- <div class="row">
        <div class="col-md-4 col-sm-4 ">
            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2>App Versions</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Settings 1</a>
                                <a class="dropdown-item" href="#">Settings 2</a>
                            </div>
                        </li>
                        <li>
                            <a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <h4>App Usage across versions</h4>
                    <div class="widget_summary">
                        <div class="w_left w_25">
                            <span>0.1.5.2</span>
                        </div>
                        <div class="w_center w_55">
                            <div class="progress">
                                <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 66%;">
                                    <span class="sr-only">60% Complete</span>
                                </div>
                            </div>
                        </div>
                        <div class="w_right w_20">
                            <span>123k</span>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="widget_summary">
                        <div class="w_left w_25">
                            <span>0.1.5.3</span>
                        </div>
                        <div class="w_center w_55">
                            <div class="progress">
                                <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 45%;">
                                    <span class="sr-only">60% Complete</span>
                                </div>
                            </div>
                        </div>
                        <div class="w_right w_20">
                            <span>53k</span>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="widget_summary">
                        <div class="w_left w_25">
                            <span>0.1.5.4</span>
                        </div>
                        <div class="w_center w_55">
                            <div class="progress">
                                <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 25%;">
                                    <span class="sr-only">60% Complete</span>
                                </div>
                            </div>
                        </div>
                        <div class="w_right w_20">
                            <span>23k</span>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="widget_summary">
                        <div class="w_left w_25">
                            <span>0.1.5.5</span>
                        </div>
                        <div class="w_center w_55">
                            <div class="progress">
                                <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 5%;">
                                    <span class="sr-only">60% Complete</span>
                                </div>
                            </div>
                        </div>
                        <div class="w_right w_20">
                            <span>3k</span>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="widget_summary">
                        <div class="w_left w_25">
                            <span>0.1.5.6</span>
                        </div>
                        <div class="w_center w_55">
                            <div class="progress">
                                <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 2%;">
                                    <span class="sr-only">60% Complete</span>
                                </div>
                            </div>
                        </div>
                        <div class="w_right w_20">
                            <span>1k</span>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-sm-4 ">
            <div class="x_panel tile fixed_height_320 overflow_hidden">
                <div class="x_title">
                    <h2>Device Usage</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Settings 1</a>
                                <a class="dropdown-item" href="#">Settings 2</a>
                            </div>
                        </li>
                        <li>
                            <a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <table class="" style="width: 100%">
                        <tr>
                            <th style="width: 37%;">
                                <p>Top 5</p>
                            </th>
                            <th>
                                <div class="col-lg-7 col-md-7 col-sm-7 ">
                                    <p class="">Device</p>
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-5 ">
                                    <p class="">Progress</p>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <canvas class="canvasDoughnut" height="140" width="140" style="margin: 15px 10px 10px 0"></canvas>
                            </td>
                            <td>
                                <table class="tile_info">
                                    <tr>
                                        <td>
                                            <p><i class="fa fa-square blue"></i>IOS </p>
                                        </td>
                                        <td>30%</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <p><i class="fa fa-square green"></i>Android </p>
                                        </td>
                                        <td>10%</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <p><i class="fa fa-square purple"></i>Blackberry </p>
                                        </td>
                                        <td>20%</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <p><i class="fa fa-square aero"></i>Symbian </p>
                                        </td>
                                        <td>15%</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <p><i class="fa fa-square red"></i>Others </p>
                                        </td>
                                        <td>30%</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-sm-4 ">
            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2>Quick Settings</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Settings 1</a>
                                <a class="dropdown-item" href="#">Settings 2</a>
                            </div>
                        </li>
                        <li>
                            <a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <div class="dashboard-widget-content">
                        <ul class="quick-list">
                            <li>
                                <i class="fa fa-calendar-o"></i><a href="#">Settings</a>
                            </li>
                            <li>
                                <i class="fa fa-bars"></i><a href="#">Subscription</a>
                            </li>
                            <li><i class="fa fa-bar-chart"></i><a href="#">Auto Renewal</a> </li>
                            <li>
                                <i class="fa fa-line-chart"></i><a href="#">Achievements</a>
                            </li>
                            <li><i class="fa fa-bar-chart"></i><a href="#">Auto Renewal</a> </li>
                            <li>
                                <i class="fa fa-line-chart"></i><a href="#">Achievements</a>
                            </li>
                            <li>
                                <i class="fa fa-area-chart"></i><a href="#">Logout</a>
                            </li>
                        </ul>
                        <div class="sidebar-widget">
                            <h4>Profile Completion</h4>
                            <canvas width="150" height="80" id="chart_gauge_01" class="" style="width: 160px; height: 100px;"></canvas>
                            <div class="goal-wrapper">
                                <span id="gauge-text" class="gauge-value pull-left">0</span>
                                <span class="gauge-value pull-left">%</span>
                                <span id="goal-text" class="goal-value pull-right">100%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">

        <div class="col-md-6 col-sm-6 ">
            <div class="x_panel">
                <div class="x_title">
                    <h2>To Do List <small>Sample tasks</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Settings 1</a>
                                <a class="dropdown-item" href="#">Settings 2</a>
                            </div>
                        </li>
                        <li>
                            <a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <div class="">
                        <ul class="to_do">
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Schedule meeting with new client
                                </p>
                            </li>
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Create email address for new intern
                                </p>
                            </li>
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Have IT fix the network printer
                                </p>
                            </li>
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Copy backups to offsite location
                                </p>
                            </li>
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Food truck fixie locavors mcsweeney
                                </p>
                            </li>
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Food truck fixie locavors mcsweeney
                                </p>
                            </li>
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Create email address for new intern
                                </p>
                            </li>
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Have IT fix the network printer
                                </p>
                            </li>
                            <li>
                                <p>
                                    <input type="checkbox" class="flat">
                                    Copy backups to offsite location
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>



        <div class="col-md-6 col-sm-6 ">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Daily active users <small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Settings 1</a>
                                <a class="dropdown-item" href="#">Settings 2</a>
                            </div>
                        </li>
                        <li>
                            <a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="temperature">
                                <b>Monday</b>, 07:30 AM
                                                    <span>F</span>
                                <span><b>C</b></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="weather-icon">
                                <canvas height="84" width="84" id="partly-cloudy-day"></canvas>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="weather-text">
                                <h2>Texas
                                            <br>
                                    <i>Partly Cloudy Day</i></h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="weather-text pull-right">
                            <h3 class="degrees">23</h3>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="row weather-days">
                        <div class="col-sm-2">
                            <div class="daily-weather">
                                <h2 class="day">Mon</h2>
                                <h3 class="degrees">25</h3>
                                <canvas id="clear-day" width="32" height="32"></canvas>
                                <h5>15 <i>km/h</i></h5>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="daily-weather">
                                <h2 class="day">Tue</h2>
                                <h3 class="degrees">25</h3>
                                <canvas height="32" width="32" id="rain"></canvas>
                                <h5>12 <i>km/h</i></h5>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="daily-weather">
                                <h2 class="day">Wed</h2>
                                <h3 class="degrees">27</h3>
                                <canvas height="32" width="32" id="snow"></canvas>
                                <h5>14 <i>km/h</i></h5>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="daily-weather">
                                <h2 class="day">Thu</h2>
                                <h3 class="degrees">28</h3>
                                <canvas height="32" width="32" id="sleet"></canvas>
                                <h5>15 <i>km/h</i></h5>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="daily-weather">
                                <h2 class="day">Fri</h2>
                                <h3 class="degrees">28</h3>
                                <canvas height="32" width="32" id="wind"></canvas>
                                <h5>11 <i>km/h</i></h5>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="daily-weather">
                                <h2 class="day">Sat</h2>
                                <h3 class="degrees">26</h3>
                                <canvas height="32" width="32" id="cloudy"></canvas>
                                <h5>10 <i>km/h</i></h5>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>--%>
</asp:Content>
