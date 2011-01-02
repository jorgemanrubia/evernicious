module Evernicious
  class EnexBuilder
    def build_enex_document(bookmarks)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.send('en-export'.to_sym){
          bookmarks.each do |bookmark|
            build_bookmark(xml, bookmark)
          end
        }
      end
      Nokogiri::XML(builder.to_xml)
    end
    
    private 
  
    def build_bookmark(xml, bookmark)
      xml.note{
        xml.title bookmark.title
        xml.content{
          xml.cdata(within_enex_note(bookmark.comments))
        }
        xml.created as_evernote_date(bookmark.added_at)
        xml.updated as_evernote_date(bookmark.added_at)
        xml.send('source-url'.to_sym, bookmark.url) 
        bookmark.tags.each do |tag|
          xml.tag tag
        end
      }
    end
  
    def within_enex_note(content)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.doc.create_internal_subset('en-note', nil,  "http://xml.evernote.com/pub/enml2.dtd")
        xml.send('en-note'.to_sym){
          xml.text(content)
        }
      end 
      builder.to_xml  
    end 
  
    def as_evernote_date(delicious_date)
      delicious_date.strftime("%Y%m%dT%H%M%SZ") 
    end
  end 
  
  # bookmarks =  BookmarksParser.new.parse(File.open("d.htm", "r"))
  # puts EnexBuilder.new.build_enex_document(bookmarks).to_xml(:encoding => 'UTF-8')
end
  

