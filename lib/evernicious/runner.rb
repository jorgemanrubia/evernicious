module Evernicious
  class Runner
    def self.generate_evernote_file(delicious_bookmarks_file_path)
      bookmarks = parse_delicious_bookmarks(delicious_bookmarks_file_path)
      evernote_contents = EnexBuilder.new.build_enex_document(bookmarks).to_xml(:encoding => 'UTF-8')
      write_contents_to_output_file("#{delicious_bookmarks_file_path}.enex", evernote_contents)
    end
    
    private
        
    def self.parse_delicious_bookmarks(delicious_bookmarks_file_path)
      delicious_bookmarks_file = File.open(delicious_bookmarks_file_path, "r")
      BookmarksParser.new.parse(delicious_bookmarks_file)
    end
    
    def self.write_contents_to_output_file(output_file_path, contents)
      File.open(output_file_path, "w"){|file| file.write(contents)}
      output_file_path
    end
  end
end