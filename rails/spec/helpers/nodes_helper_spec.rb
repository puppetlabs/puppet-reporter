require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NodesHelper do
  
  it 'should create a report count graph' do
    helper.should respond_to(:report_count_graph)
  end
  
  describe 'creating a report count graph' do
    before :each do
      helper.stubs(:sparkline_tag)
      Report.stubs(:count_between)
    end
    
    it 'should create a sparkline' do
      helper.expects(:sparkline_tag)
      helper.report_count_graph
    end
    
    it 'should get report count data' do
      Report.expects(:count_between)
      helper.report_count_graph
    end
    
    it 'should get report count data for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)
      
      Report.expects(:count_between).with(now - 1.day, now, :interval => 30.minutes)
      helper.report_count_graph
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      Report.expects(:count_between).with(time - 1.day, time, :interval => 30.minutes)
      helper.report_count_graph(time)
    end
    
    it 'should create a sparkline using the report count data' do
      data_points = stub('data points')
      Report.stubs(:count_between).returns(data_points)
      helper.expects(:sparkline_tag).with(data_points, anything)
      helper.report_count_graph
    end
    
    it 'should create a smooth sparkline' do
      helper.expects(:sparkline_tag).with(anything, has_entry(:type => 'smooth'))
      helper.report_count_graph
    end
    
    it 'should return the sparkline tag' do
      sparkline = stub('sparkline')
      helper.stubs(:sparkline_tag).returns(sparkline)
      helper.report_count_graph.should == sparkline
    end
  end
  
  it 'should create a node report count graph' do
    helper.should respond_to(:node_report_count_graph)
  end

  describe 'creating a node report count graph' do
    before :each do
      @node = Node.generate!
      helper.stubs(:sparkline_tag)
      @node.reports.stubs(:count_between)
    end
    
    it 'should require a node' do
      lambda { helper.node_report_count_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_report_count_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should create a sparkline' do
      helper.expects(:sparkline_tag)
      helper.node_report_count_graph(@node)
    end

    it 'should get report count data for the node' do
      @node.reports.expects(:count_between)
      helper.node_report_count_graph(@node)
    end

    it 'should get report count data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.reports.expects(:count_between).with(now - 1.day, now, :interval => 30.minutes)
      helper.node_report_count_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.reports.expects(:count_between).with(time - 1.day, time, :interval => 30.minutes)
      helper.node_report_count_graph(@node, time)
    end

    it 'should create a sparkline using the report count data' do
      data_points = stub('data points')
      @node.reports.stubs(:count_between).returns(data_points)
      helper.expects(:sparkline_tag).with(data_points, anything)
      helper.node_report_count_graph(@node)
    end

    it 'should create a discrete sparkline' do
      helper.expects(:sparkline_tag).with(anything, has_entry(:type => 'discrete'))
      helper.node_report_count_graph(@node)
    end

    it 'should return the sparkline tag' do
      sparkline = stub('sparkline')
      helper.stubs(:sparkline_tag).returns(sparkline)
      helper.node_report_count_graph(@node).should == sparkline
    end
  end
  
  it 'should create a total change graph' do
    helper.should respond_to(:total_change_graph)
  end
  
  describe 'creating a total change graph' do
    before :each do
      helper.stubs(:sparkline_tag)
      Metric.stubs(:total_changes_between)
    end
    
    it 'should create a sparkline' do
      helper.expects(:sparkline_tag)
      helper.total_change_graph
    end
    
    it 'should get total change data' do
      Metric.expects(:total_changes_between)
      helper.total_change_graph
    end
    
    it 'should get total change data for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)
      
      Metric.expects(:total_changes_between).with(now - 1.day, now, :interval => 30.minutes)
      helper.total_change_graph
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      Metric.expects(:total_changes_between).with(time - 1.day, time, :interval => 30.minutes)
      helper.total_change_graph(time)
    end
    
    it 'should create a sparkline using the total change data' do
      data_points = stub('data points')
      Metric.stubs(:total_changes_between).returns(data_points)
      helper.expects(:sparkline_tag).with(data_points, anything)
      helper.total_change_graph
    end
    
    it 'should create a smooth sparkline' do
      helper.expects(:sparkline_tag).with(anything, has_entry(:type => 'smooth'))
      helper.total_change_graph
    end
    
    it 'should return the sparkline tag' do
      sparkline = stub('sparkline')
      helper.stubs(:sparkline_tag).returns(sparkline)
      helper.total_change_graph.should == sparkline
    end
  end
  
  it 'should create a node total change graph' do
    helper.should respond_to(:node_total_change_graph)
  end

  describe 'creating a node total change graph' do
    before :each do
      @node = Node.generate!
      helper.stubs(:sparkline_tag)
      @node.metrics.stubs(:total_changes_between)
    end
    
    it 'should require a node' do
      lambda { helper.node_total_change_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_total_change_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should create a sparkline' do
      helper.expects(:sparkline_tag)
      helper.node_total_change_graph(@node)
    end

    it 'should get total change data for the node' do
      @node.metrics.expects(:total_changes_between)
      helper.node_total_change_graph(@node)
    end

    it 'should get total change data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_changes_between).with(now - 1.day, now, :interval => 30.minutes)
      helper.node_total_change_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_changes_between).with(time - 1.day, time, :interval => 30.minutes)
      helper.node_total_change_graph(@node, time)
    end

    it 'should create a sparkline using the total change data' do
      data_points = stub('data points')
      @node.metrics.stubs(:total_changes_between).returns(data_points)
      helper.expects(:sparkline_tag).with(data_points, anything)
      helper.node_total_change_graph(@node)
    end

    it 'should create a smooth sparkline' do
      helper.expects(:sparkline_tag).with(anything, has_entry(:type => 'smooth'))
      helper.node_total_change_graph(@node)
    end

    it 'should return the sparkline tag' do
      sparkline = stub('sparkline')
      helper.stubs(:sparkline_tag).returns(sparkline)
      helper.node_total_change_graph(@node).should == sparkline
    end
  end
  
  it 'should create a total failure graph' do
    helper.should respond_to(:total_failure_graph)
  end
  
  describe 'creating a total failure graph' do
    before :each do
      helper.stubs(:sparkline_tag)
      Metric.stubs(:total_failures_between)
    end
    
    it 'should create a sparkline' do
      helper.expects(:sparkline_tag)
      helper.total_failure_graph
    end
    
    it 'should get total failure data' do
      Metric.expects(:total_failures_between)
      helper.total_failure_graph
    end
    
    it 'should get total failure data for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)
      
      Metric.expects(:total_failures_between).with(now - 1.day, now, :interval => 30.minutes)
      helper.total_failure_graph
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      Metric.expects(:total_failures_between).with(time - 1.day, time, :interval => 30.minutes)
      helper.total_failure_graph(time)
    end
    
    it 'should create a sparkline using the total failure data' do
      data_points = stub('data points')
      Metric.stubs(:total_failures_between).returns(data_points)
      helper.expects(:sparkline_tag).with(data_points, anything)
      helper.total_failure_graph
    end
    
    it 'should create a smooth sparkline' do
      helper.expects(:sparkline_tag).with(anything, has_entry(:type => 'smooth'))
      helper.total_failure_graph
    end
    
    it 'should return the sparkline tag' do
      sparkline = stub('sparkline')
      helper.stubs(:sparkline_tag).returns(sparkline)
      helper.total_failure_graph.should == sparkline
    end
  end
  
  it 'should create a node total failure graph' do
    helper.should respond_to(:node_total_failure_graph)
  end

  describe 'creating a node total failure graph' do
    before :each do
      @node = Node.generate!
      helper.stubs(:sparkline_tag)
      @node.metrics.stubs(:total_failures_between)
    end
    
    it 'should require a node' do
      lambda { helper.node_total_failure_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_total_failure_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should create a sparkline' do
      helper.expects(:sparkline_tag)
      helper.node_total_failure_graph(@node)
    end

    it 'should get total failure data for the node' do
      @node.metrics.expects(:total_failures_between)
      helper.node_total_failure_graph(@node)
    end

    it 'should get total failure data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_failures_between).with(now - 1.day, now, :interval => 30.minutes)
      helper.node_total_failure_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_failures_between).with(time - 1.day, time, :interval => 30.minutes)
      helper.node_total_failure_graph(@node, time)
    end

    it 'should create a sparkline using the total failure data' do
      data_points = stub('data points')
      @node.metrics.stubs(:total_failures_between).returns(data_points)
      helper.expects(:sparkline_tag).with(data_points, anything)
      helper.node_total_failure_graph(@node)
    end

    it 'should create a smooth sparkline' do
      helper.expects(:sparkline_tag).with(anything, has_entry(:type => 'smooth'))
      helper.node_total_failure_graph(@node)
    end

    it 'should return the sparkline tag' do
      sparkline = stub('sparkline')
      helper.stubs(:sparkline_tag).returns(sparkline)
      helper.node_total_failure_graph(@node).should == sparkline
    end
  end
  
  it 'should create a total resource graph' do
    helper.should respond_to(:total_resource_graph)
  end
  
  describe 'creating a total resource graph' do
    before :each do
      helper.stubs(:sparkline_tag)
      Metric.stubs(:total_resources_between)
    end
    
    it 'should create a sparkline' do
      helper.expects(:sparkline_tag)
      helper.total_resource_graph
    end
    
    it 'should get total resource data' do
      Metric.expects(:total_resources_between)
      helper.total_resource_graph
    end
    
    it 'should get total resource data for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)
      
      Metric.expects(:total_resources_between).with(now - 1.day, now, :interval => 30.minutes)
      helper.total_resource_graph
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      Metric.expects(:total_resources_between).with(time - 1.day, time, :interval => 30.minutes)
      helper.total_resource_graph(time)
    end
    
    it 'should create a sparkline using the total resource data' do
      data_points = stub('data points')
      Metric.stubs(:total_resources_between).returns(data_points)
      helper.expects(:sparkline_tag).with(data_points, anything)
      helper.total_resource_graph
    end
    
    it 'should create a smooth sparkline' do
      helper.expects(:sparkline_tag).with(anything, has_entry(:type => 'smooth'))
      helper.total_resource_graph
    end
    
    it 'should return the sparkline tag' do
      sparkline = stub('sparkline')
      helper.stubs(:sparkline_tag).returns(sparkline)
      helper.total_resource_graph.should == sparkline
    end
  end
  
  it 'should create a node total resource graph' do
    helper.should respond_to(:node_total_resource_graph)
  end

  describe 'creating a node total resource graph' do
    before :each do
      @node = Node.generate!
      helper.stubs(:sparkline_tag)
      @node.metrics.stubs(:total_resources_between)
    end
    
    it 'should require a node' do
      lambda { helper.node_total_resource_graph }.should raise_error(ArgumentError)
    end
    
    it 'should accept a node' do
      lambda { helper.node_total_resource_graph(@node) }.should_not raise_error(ArgumentError)
    end

    it 'should create a sparkline' do
      helper.expects(:sparkline_tag)
      helper.node_total_resource_graph(@node)
    end

    it 'should get total resource data for the node' do
      @node.metrics.expects(:total_resources_between)
      helper.node_total_resource_graph(@node)
    end

    it 'should get total resource data for the node for 30 minute intervals over the past day' do
      now = Time.zone.now
      Time.zone.stubs(:now).returns(now)

      @node.metrics.expects(:total_resources_between).with(now - 1.day, now, :interval => 30.minutes)
      helper.node_total_resource_graph(@node)
    end
    
    it 'should use a passed-in time' do
      time = Time.zone.now - 1234
      
      @node.metrics.expects(:total_resources_between).with(time - 1.day, time, :interval => 30.minutes)
      helper.node_total_resource_graph(@node, time)
    end

    it 'should create a sparkline using the total resource data' do
      data_points = stub('data points')
      @node.metrics.stubs(:total_resources_between).returns(data_points)
      helper.expects(:sparkline_tag).with(data_points, anything)
      helper.node_total_resource_graph(@node)
    end

    it 'should create a smooth sparkline' do
      helper.expects(:sparkline_tag).with(anything, has_entry(:type => 'smooth'))
      helper.node_total_resource_graph(@node)
    end

    it 'should return the sparkline tag' do
      sparkline = stub('sparkline')
      helper.stubs(:sparkline_tag).returns(sparkline)
      helper.node_total_resource_graph(@node).should == sparkline
    end
  end
end
