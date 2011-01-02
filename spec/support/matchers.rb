
Spec::Matchers.define :be_parsed_as do |expected_bookmarks|
  match do |bookmarks_code|
    @parsed_bookmarks = Evernicious::BookmarksParser.new().parse(within_bookmarks_document(bookmarks_code))
    @parsed_bookmarks.should == expected_bookmarks
  end
  
  failure_message_for_should do |actual_bookmarks|
    "expecting to parse:
    #{expected_bookmarks}

    but parsed:
    #{@parsed_bookmarks}"
  end

end

Spec::Matchers.define :generate_enex_document do |expected_nodes_properties_list|
  
  def compare_contents(expected_content, actual_content_cdata)
    actual_content = Nokogiri::XML(actual_content_cdata).at_css('en-note').text
    actual_content == expected_content
  end
  
  def compare_dates(expected_date_with_delicious_format, actual_date)
    expected_date = expected_date_with_delicious_format.strftime("%Y%m%dT%H%M%SZ")
    expected_date == expected_date
  end
  
  def compare_tags(expected_tags, tag_nodes)
    return tag_nodes.empty? if !expected_tags || expected_tags.empty?
    tag_nodes.collect{|tag_node| tag_node.text} == expected_tags
  end
  

  match do |bookmarks_properties_list|
    bookmarks = build_list_of_objects(bookmarks_properties_list)
    expected_nodes = build_list_of_objects(expected_nodes_properties_list)
    
    @generated_enex_document = Evernicious::EnexBuilder.new().build_enex_document(bookmarks)
    
    generated_notes = @generated_enex_document.css('note')
    matched = bookmarks.size == generated_notes.size 
    generated_notes.each_with_index do |enex_note_node, index|
      expected_node = expected_nodes[index]
      
      unless !matched
        matched = enex_note_node.at_css('title').text == expected_node.title   &&
        matched = enex_note_node.at_css('source-url').text == expected_node.url   &&
                  compare_contents(expected_node.content, enex_note_node.at_css('content').child.text) &&
                  compare_dates(expected_node.created, enex_note_node.at_css('created').text) &&
                  compare_dates(expected_node.created, enex_note_node.at_css('updated').text) &&
                  compare_tags(expected_node.tags, enex_note_node.css('tag'))
      end
    end

    matched
  end
  
  failure_message_for_should do |actual_bookmarks|
    "expecting to generate a document with the following nodes:
    #{expected_nodes_properties_list.inspect}

    but generated the next document:
    #{@generated_enex_document}"
  end

end
