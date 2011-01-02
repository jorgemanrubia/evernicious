module BookmarkHelpers
  def within_bookmarks_document(content)
    %{
      <!DOCTYPE NETSCAPE-Bookmark-file-1>
      <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
      <TITLE>Bookmarks</TITLE>
      <H1>Bookmarks</H1>
      #{content}
    }
  end
  
  def build_list_of_objects(properties_list)
    properties_list.collect{|properties| OpenStruct.new(properties)}
  end
end  