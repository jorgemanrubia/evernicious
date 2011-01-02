module Evernicious
  class BookmarksParser
    def parse(bookmarks_code_source)
      document = Nokogiri::HTML(bookmarks_code_source, nil, 'UTF-8')
      #Delicious HTML format has unclosed tags and presents problems with nokogiri. See XPath expression at http://goo.gl/Cm7Zn
      build_bookmars document.xpath('//dt/a | //dt[a]/following-sibling::*[1][self::dd]')
    end

    private

    def build_bookmars(a_or_dd_nodes)
      bookmarks = []
      a_or_dd_nodes.each_with_index do |a_or_dd_node, index|
        next if is_dd_node?(a_or_dd_node)
        bookmarks << build_bookmark(a_or_dd_node, a_or_dd_nodes[index+1])
      end
      bookmarks
    end

    def build_bookmark(a_node, next_node)
      OpenStruct.new :title=>a_node.text,
        :added_at=>Time.at(a_node['add_date'].to_i),
        :url=>a_node['href'],
        :tags=>build_tags_from_string(a_node['tags']),
        :comments=>is_dd_node?(next_node) ? next_node.inner_html : ''
    end

    def is_dd_node?(node)
      node && node.name == 'dd'
    end

    def build_tags_from_string(tags_as_string)
      tags_as_string ? tags_as_string.split(/,/).find_all{|tag| !tag.strip.empty?} : []
    end
  end
end

