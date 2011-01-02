require "spec_helper"

describe Evernicious::Runner do
  describe "generate_evernote_file" do
    before(:each) do
      @input_file = mock('the input file', "empty?"=>nil)
      @bookmarks_parser = mock('the bookmarks parser')
      @bookmarks = mock('the bookmarks')
      @enex_builder = mock('the enex builder')
      @output_file = mock('the output file')
    end
    
    it "should parse the provided bookmars file, build the enex document for them and write the results in a file which name is the source name plus the 'enex' extension" do
      File.should_receive(:open).with('the-input-file.htm', 'r').and_return @input_file
      Evernicious::BookmarksParser.should_receive(:new).and_return @bookmarks_parser
      @bookmarks_parser.should_receive(:parse).with(@input_file).and_return @bookmarks
      
      Evernicious::EnexBuilder.should_receive(:new).and_return @enex_builder
      @enex_builder.should_receive(:build_enex_document).with(@bookmarks).and_return mock('the evernote xml document', :to_xml=>'the evernote xml')
      
      File.should_receive(:open).with('the-input-file.htm.enex', 'w').and_yield @output_file
      @output_file.should_receive(:write).with('the evernote xml')
      Evernicious::Runner.generate_evernote_file('the-input-file.htm')
    end
  end
end