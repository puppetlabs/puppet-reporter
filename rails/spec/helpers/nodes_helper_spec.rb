require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NodesHelper do
  
  it 'should create a report count graph' do
    helper.should respond_to(:report_count_graph)
  end
  
  describe 'creating a report count graph' do
    before :each do
      helper.stubs(:sparkline_tag)
      Report.stubs(:count_between).returns([])
    end
    
    it 'should get report count data' do
      Report.expects(:count_between).returns([])
      helper.report_count_graph
    end
    
    it 'should get report count data for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)
      
      Report.expects(:count_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.report_count_graph
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      Report.expects(:count_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.report_count_graph(time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.report_count_graph
      result.should have_tag('div[id=?][class=?]', 'report_count_graph', 'index_graph_placeholder')
    end
    
    it 'should create a graph using the report count data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      Report.stubs(:count_between).returns(data_points)
      result = helper.report_count_graph
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node report count graph' do
    helper.should respond_to(:node_report_count_graph)
  end
  
  describe 'creating a node report count graph' do
    before :each do
      @node = Node.generate!
      @node.reports.stubs(:count_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_report_count_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_report_count_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should get report count data for the node' do
      @node.reports.expects(:count_between).returns([])
      helper.node_report_count_graph(@node)
    end

    it 'should get report count data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.reports.expects(:count_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.node_report_count_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.reports.expects(:count_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.node_report_count_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_report_count_graph(@node)
      result.should have_tag('div[id=?][class=?]', "node_#{@node.id}_report_graph", 'index_graph_placeholder')
    end
    
    it 'should create a graph using the report count data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.reports.stubs(:count_between).returns(data_points)
      result = helper.node_report_count_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a total change graph' do
    helper.should respond_to(:total_change_graph)
  end
  
  describe 'creating a total change graph' do
    before :each do
      helper.stubs(:sparkline_tag)
      Metric.stubs(:total_changes_between).returns([])
    end
    
    it 'should get total change data' do
      Metric.expects(:total_changes_between).returns([])
      helper.total_change_graph
    end
    
    it 'should get total change data for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)
      
      Metric.expects(:total_changes_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.total_change_graph
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      Metric.expects(:total_changes_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.total_change_graph(time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.total_change_graph
      result.should have_tag('div[id=?][class=?]', 'total_change_graph', 'index_graph_placeholder')
    end
    
    it 'should create a graph using the total resource data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      Metric.stubs(:total_changes_between).returns(data_points)
      result = helper.total_change_graph
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node total change graph' do
    helper.should respond_to(:node_total_change_graph)
  end

  describe 'creating a node total change graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_changes_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_total_change_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_total_change_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should get total change data for the node' do
      @node.metrics.expects(:total_changes_between).returns([])
      helper.node_total_change_graph(@node)
    end

    it 'should get total change data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_changes_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.node_total_change_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_changes_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.node_total_change_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_total_change_graph(@node)
      result.should have_tag('div[id=?][class=?]', "node_#{@node.id}_change_graph", 'index_graph_placeholder')
    end
    
    it 'should create a graph using the total change data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_changes_between).returns(data_points)
      result = helper.node_total_change_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a total failure graph' do
    helper.should respond_to(:total_failure_graph)
  end
  
  describe 'creating a total failure graph' do
    before :each do
      helper.stubs(:sparkline_tag)
      Metric.stubs(:total_failures_between).returns([])
    end
    
    it 'should get total failure data' do
      Metric.expects(:total_failures_between).returns([])
      helper.total_failure_graph
    end
    
    it 'should get total failure data for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)
      
      Metric.expects(:total_failures_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.total_failure_graph
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      Metric.expects(:total_failures_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.total_failure_graph(time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.total_failure_graph
      result.should have_tag('div[id=?][class=?]', 'total_failure_graph', 'index_graph_placeholder')
    end
    
    it 'should create a graph using the total resource data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      Metric.stubs(:total_failures_between).returns(data_points)
      result = helper.total_failure_graph
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node total failure graph' do
    helper.should respond_to(:node_total_failure_graph)
  end

  describe 'creating a node total failure graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_failures_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_total_failure_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_total_failure_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should get total failure data for the node' do
      @node.metrics.expects(:total_failures_between).returns([])
      helper.node_total_failure_graph(@node)
    end

    it 'should get total failure data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_failures_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.node_total_failure_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_failures_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.node_total_failure_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_total_failure_graph(@node)
      result.should have_tag('div[id=?][class=?]', "node_#{@node.id}_failure_graph", 'index_graph_placeholder')
    end
    
    it 'should create a graph using the total failure data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_failures_between).returns(data_points)
      result = helper.node_total_failure_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a total resource graph' do
    helper.should respond_to(:total_resource_graph)
  end
  
  describe 'creating a total resource graph' do
    before :each do
      helper.stubs(:sparkline_tag)
      Metric.stubs(:total_resources_between).returns([])
    end
    
    it 'should get total resource data' do
      Metric.expects(:total_resources_between).returns([])
      helper.total_resource_graph
    end
    
    it 'should get total resource data for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)
      
      Metric.expects(:total_resources_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.total_resource_graph
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      Metric.expects(:total_resources_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.total_resource_graph(time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.total_resource_graph
      result.should have_tag('div[id=?][class=?]', 'total_resource_graph', 'index_graph_placeholder')
    end
    
    it 'should create a graph using the total resource data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      Metric.stubs(:total_resources_between).returns(data_points)
      result = helper.total_resource_graph
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node total resource graph' do
    helper.should respond_to(:node_total_resource_graph)
  end

  describe 'creating a node total resource graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_resources_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_total_resource_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_total_resource_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should get total resource data for the node' do
      @node.metrics.expects(:total_resources_between).returns([])
      helper.node_total_resource_graph(@node)
    end

    it 'should get total resource data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_resources_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.node_total_resource_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_resources_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.node_total_resource_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_total_resource_graph(@node)
      result.should have_tag('div[id=?][class=?]', "node_#{@node.id}_resource_graph", 'index_graph_placeholder')
    end
    
    it 'should create a graph using the total resource data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_resources_between).returns(data_points)
      result = helper.node_total_resource_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node day report graph' do
    helper.should respond_to(:node_day_report_graph)
  end

  describe 'creating a node day report graph' do
    before :each do
      @node = Node.generate!
      @node.reports.stubs(:count_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_day_report_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_day_report_graph(@node) }.should_not raise_error(ArgumentError)
    end
    
    it 'should get report count data for the node' do
      @node.reports.expects(:count_between).returns([])
      helper.node_day_report_graph(@node)
    end

    it 'should get report count data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.reports.expects(:count_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.node_day_report_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.reports.expects(:count_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.node_day_report_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_day_report_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_day_report_graph', 'day_graph_placeholder')
    end
    
    it 'should create a graph using the report count data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.reports.stubs(:count_between).returns(data_points)
      result = helper.node_day_report_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node week report graph' do
    helper.should respond_to(:node_week_report_graph)
  end

  describe 'creating a node week report graph' do
    before :each do
      @node = Node.generate!
      @node.reports.stubs(:count_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_week_report_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_week_report_graph(@node) }.should_not raise_error(ArgumentError)
    end
    
    it 'should get report count data for the node' do
      @node.reports.expects(:count_between).returns([])
      helper.node_week_report_graph(@node)
    end

    it 'should get report count data for the node for one-day intervals over the past seven days' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.reports.expects(:count_between).with(now - 7.days, now, :interval => 1.day).returns([])
      helper.node_week_report_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.reports.expects(:count_between).with(time - 7.days, time, :interval => 1.day).returns([])
      helper.node_week_report_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_week_report_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_week_report_graph', 'week_graph_placeholder')
    end
    
    it 'should create a graph using the report count data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.reports.stubs(:count_between).returns(data_points)
      result = helper.node_week_report_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node month report graph' do
    helper.should respond_to(:node_month_report_graph)
  end

  describe 'creating a node month report graph' do
    before :each do
      @node = Node.generate!
      @node.reports.stubs(:count_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_month_report_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_month_report_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should get report count data for the node' do
      @node.reports.expects(:count_between).returns([])
      helper.node_month_report_graph(@node)
    end

    it 'should get report count data for the node for one-day intervals over the past 30 days' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.reports.expects(:count_between).with(now - 30.days, now, :interval => 1.day).returns([])
      helper.node_month_report_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.reports.expects(:count_between).with(time - 30.days, time, :interval => 1.day).returns([])
      helper.node_month_report_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_month_report_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_month_report_graph', 'month_graph_placeholder')
    end
    
    it 'should create a graph using the report count data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.reports.stubs(:count_between).returns(data_points)
      result = helper.node_month_report_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node day failure graph' do
    helper.should respond_to(:node_day_failure_graph)
  end

  describe 'creating a node day failure graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_failures_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_day_failure_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_day_failure_graph(@node) }.should_not raise_error(ArgumentError)
    end
    
    it 'should get total failure data for the node' do
      @node.metrics.expects(:total_failures_between).returns([])
      helper.node_day_failure_graph(@node)
    end

    it 'should get total failure data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_failures_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.node_day_failure_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_failures_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.node_day_failure_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_day_failure_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_day_failure_graph', 'day_graph_placeholder')
    end
    
    it 'should create a graph using the total failure data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_failures_between).returns(data_points)
      result = helper.node_day_failure_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node week failure graph' do
    helper.should respond_to(:node_week_failure_graph)
  end

  describe 'creating a node week failure graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_failures_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_week_failure_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_week_failure_graph(@node) }.should_not raise_error(ArgumentError)
    end
    
    it 'should get total failure data for the node' do
      @node.metrics.expects(:total_failures_between).returns([])
      helper.node_week_failure_graph(@node)
    end

    it 'should get total failure data for the node for one-day intervals over the past seven days' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_failures_between).with(now - 7.days, now, :interval => 1.day).returns([])
      helper.node_week_failure_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_failures_between).with(time - 7.days, time, :interval => 1.day).returns([])
      helper.node_week_failure_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_week_failure_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_week_failure_graph', 'week_graph_placeholder')
    end
    
    it 'should create a graph using the total failure data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_failures_between).returns(data_points)
      result = helper.node_week_failure_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node month failure graph' do
    helper.should respond_to(:node_month_failure_graph)
  end
  
  describe 'creating a node month failure graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_failures_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_month_failure_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_month_failure_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should get total failure data for the node' do
      @node.metrics.expects(:total_failures_between).returns([])
      helper.node_month_failure_graph(@node)
    end

    it 'should get total failure data for the node for one-day intervals over the past 30 days' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_failures_between).with(now - 30.days, now, :interval => 1.day).returns([])
      helper.node_month_failure_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_failures_between).with(time - 30.days, time, :interval => 1.day).returns([])
      helper.node_month_failure_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_month_failure_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_month_failure_graph', 'month_graph_placeholder')
    end
    
    it 'should create a graph using the total failure data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_failures_between).returns(data_points)
      result = helper.node_month_failure_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
    
  it 'should create a node day resource graph' do
    helper.should respond_to(:node_day_resource_graph)
  end

  describe 'creating a node day resource graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_resources_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_day_resource_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_day_resource_graph(@node) }.should_not raise_error(ArgumentError)
    end
    
    it 'should get total resource data for the node' do
      @node.metrics.expects(:total_resources_between).returns([])
      helper.node_day_resource_graph(@node)
    end

    it 'should get total resource data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_resources_between).with(now - 1.day, now, :interval => 30.minutes).returns([])
      helper.node_day_resource_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_resources_between).with(time - 1.day, time, :interval => 30.minutes).returns([])
      helper.node_day_resource_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_day_resource_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_day_resource_graph', 'day_graph_placeholder')
    end
    
    it 'should create a graph using the total resource data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_resources_between).returns(data_points)
      result = helper.node_day_resource_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node week resource graph' do
    helper.should respond_to(:node_week_resource_graph)
  end

  describe 'creating a node week resource graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_resources_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_week_resource_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_week_resource_graph(@node) }.should_not raise_error(ArgumentError)
    end
    
    it 'should get total resource data for the node' do
      @node.metrics.expects(:total_resources_between).returns([])
      helper.node_week_resource_graph(@node)
    end

    it 'should get total resource data for the node for one-day intervals over the past seven days' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_resources_between).with(now - 7.days, now, :interval => 1.day).returns([])
      helper.node_week_resource_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_resources_between).with(time - 7.days, time, :interval => 1.day).returns([])
      helper.node_week_resource_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_week_resource_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_week_resource_graph', 'week_graph_placeholder')
    end
    
    it 'should create a graph using the total resource data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_resources_between).returns(data_points)
      result = helper.node_week_resource_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
  it 'should create a node month resource graph' do
    helper.should respond_to(:node_month_resource_graph)
  end

  describe 'creating a node month resource graph' do
    before :each do
      @node = Node.generate!
      @node.metrics.stubs(:total_resources_between).returns([])
    end
    
    it 'should require a node' do
      lambda { helper.node_month_resource_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_month_resource_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should get total resource data for the node' do
      @node.metrics.expects(:total_resources_between).returns([])
      helper.node_month_resource_graph(@node)
    end

    it 'should get total resource data for the node for one-day intervals over the past 30 days' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_resources_between).with(now - 30.days, now, :interval => 1.day).returns([])
      helper.node_month_resource_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_resources_between).with(time - 30.days, time, :interval => 1.day).returns([])
      helper.node_month_resource_graph(@node, time)
    end
    
    it 'should make a placeholder for the graph' do
      result = helper.node_month_resource_graph(@node)
      result.should have_tag('div[id=?][class=?]', 'node_month_resource_graph', 'month_graph_placeholder')
    end
    
    it 'should create a graph using the total resource data' do
      data_points = [1,2,3]
      expected_points = [[0,1], [1,2], [2,3]]
      @node.metrics.stubs(:total_resources_between).returns(data_points)
      result = helper.node_month_resource_graph(@node)
      result.should match(Regexp.new(Regexp.escape(expected_points.inspect)))
    end
  end
  
end
