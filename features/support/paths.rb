module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /the Ring of Reciprocity requests page/
      '/requests'
    when /the create request page/
      '/requests/new'
    # Add more mappings as needed
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end

  def link_to(link_text)
    case link_text
    when 'New Request'
      '/requests/new'
    when 'Edit Request'
      '/requests/edit'
    when 'Edit'
      '/reviews/edit'
    # Add more mappings as needed
    else
      raise "Can't find mapping from \"#{link_text}\" to a link."
    end
  end
end

World(NavigationHelpers)