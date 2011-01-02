require "spec_helper"

describe Evernicious::BookmarksParser do
  it "should return an empty list when no bookmarks found" do
    ''.should be_parsed_as []
  end
  
  it "should parse a simple bookmark" do
    %{
      <DL><p><DT><A HREF="http://the.url" ADD_DATE="1280913776" PRIVATE="0" TAGS="">The title</A></DL>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1280913776), :comments=>"", :tags=>[])
      ]
  end
  
  it "should parse a bookmark with a comment" do
    %{
      <DL><p><DT><A HREF="http://the.url" ADD_DATE="1380913776" PRIVATE="0" TAGS="">The title</A>
      <DD>This is the comment</DL>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>"This is the comment", :tags=>[])
      ]
  end
  
  it "should parse a bookmark with an HTML comment with breaklines" do
    html_comment = %{First line<br>Second line<br>}
     
    %{
      <DL><p><DT><A HREF="http://the.url" ADD_DATE="1380913776" PRIVATE="0" TAGS="">The title</A>
      <DD>#{html_comment}</DL>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>html_comment, :tags=>[])
      ]
  end
  
  it "should parse a bookmark with one tags" do
    %{
      <DL><p><DT><A HREF="http://the.url" ADD_DATE="1380913776" PRIVATE="0" TAGS="tag-1">The title</A>
      <DD>This is the comment</DL>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>"This is the comment", :tags=>%W(tag-1))
      ]
  end
  
  it "should parse a bookmark with no TAGS attribute" do
    %{
      <DL><p><DT><A HREF="http://the.url" ADD_DATE="1380913776" PRIVATE="0">The title</A>
      <DD>This is the comment</DL>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>"This is the comment", :tags=>[])
      ]
  end
  
  it "should parse a bookmark with many tags" do
    %{
      <DL><p><DT><A HREF="http://the.url" ADD_DATE="1380913776" PRIVATE="0" TAGS="tag-1,tag-2,tag-3">The title</A>
      <DD>This is the comment</DL>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>"This is the comment", :tags=>%W(tag-1 tag-2 tag-3))
      ]
  end
  
  it "should parse a bookmark with tags ignoring empty ones" do
    %{
      <DL><p><DT><A HREF="http://the.url" ADD_DATE="1380913776" PRIVATE="0" TAGS="tag-1, ,,tag-2,  ,,tag-3">The title</A>
      <DD>This is the comment</DL>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>"This is the comment", :tags=>%W(tag-1 tag-2 tag-3))
      ]
  end
  
  
  it "should parse many bookmarks" do
    %{ 
      <DL><DT><A HREF="http://the.url.1" ADD_DATE="1380913770" PRIVATE="0" TAGS="">The title 1</A><DD>This is the comment 1<DT><A HREF="http://the.url.2" ADD_DATE="1380913771" PRIVATE="0" TAGS="tag-1,tag-2,tag-3">The title 2</A>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title 1', :url=>'http://the.url.1', :added_at=>Time.at(1380913770), :comments=>"This is the comment 1", :tags=>[]),
      OpenStruct.new(:title=>'The title 2', :url=>'http://the.url.2', :added_at=>Time.at(1380913771), :comments=>"", :tags=>%W(tag-1 tag-2 tag-3))
      ]
  end
  
  it "should parse bookmars without comments (without dd nodes)" do
    %{
      <DL><DT><A HREF="http://the.url.1" ADD_DATE="1380913770" PRIVATE="0" TAGS="">The title 1</A>
      <DT><A HREF="http://the.url.2" ADD_DATE="1380913771" PRIVATE="0" TAGS="">The title 2</A>
      <DD>Some comment</DL>
    }.should be_parsed_as [
      OpenStruct.new(:title=>'The title 1', :url=>'http://the.url.1', :added_at=>Time.at(1380913770), :comments=>"", :tags=>[]),
      OpenStruct.new(:title=>'The title 2', :url=>'http://the.url.2', :added_at=>Time.at(1380913771), :comments=>"Some comment", :tags=>[])
    ]
  end
  
  
   
end
