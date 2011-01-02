require "spec_helper"

describe Evernicious::EnexBuilder do
  it "should generate a proper Enex document for a simple bookmark without comments nor tags" do
    [{:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>"", :tags=>[]}].should generate_enex_document [{
      :title=>"The title",
      :content=>"",
      :url=>'http://the.url',
      :created=>Time.at(1380913776),
      :updated=>Time.at(1380913776)
    }]
  end
  
  it "should generate a proper Enex document for a simple bookmark with comments" do
    [{:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>"The comment 1", :tags=>[]}].should generate_enex_document [{
      :title=>"The title",
      :content=>"The comment 1", 
      :url=>'http://the.url',
      :created=>Time.at(1380913776),
      :updated=>Time.at(1380913776)
    }]
  end
  
  it "should generate a proper Enex document for a simple bookmark with tags" do
    [{:title=>'The title', :url=>'http://the.url', :added_at=>Time.at(1380913776), :comments=>"", :tags=>%W{tag-1 tag-2 tag-3}}].should generate_enex_document [{
      :title=>"The title",
      :content=>"", 
      :url=>'http://the.url',
      :created=>Time.at(1380913776),
      :updated=>Time.at(1380913776), 
      :tags=>%W{tag-1 tag-2 tag-3}
    }]
  end
  
  it "should generate a proper Enex document for two bookmarks" do
    [{:title=>'The title 1', :url=>'http://the.url.1', :added_at=>Time.at(1380913770), :comments=>"comment 1", :tags=>%W{tag-1-1 tag-1-2 tag-1-3}},
     {:title=>'The title 2', :url=>'http://the.url.2', :added_at=>Time.at(1380913771), :comments=>"comment 2", :tags=>%W{tag-2-1 tag-2-2 tag-2-3}} 
      ].should generate_enex_document [
    {
      :title=>"The title 1",
      :content=>"comment 1", 
      :url=>'http://the.url.1',
      :created=>Time.at(1380913770),
      :updated=>Time.at(1380913770),
      :tags=>%W{tag-1-1 tag-1-2 tag-1-3}
    },
    {
      :title=>"The title 2",
      :content=>"comment 2", 
      :url=>'http://the.url.2',
      :created=>Time.at(1380913771),
      :updated=>Time.at(1380913771),
      :tags=>%W{tag-2-1 tag-2-2 tag-2-3}
    }]
  end
  
  
end

 