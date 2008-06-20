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
end
