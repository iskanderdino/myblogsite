class ArticlePage
  include PageObject

  text_field(:title, :id => "title")
  text_area(:description, :id => "description")
  button(:save, :value => "Save")
  link(:back, :id => "back")

  def create_update_article(title, description)
    puts "title: #{title}"
    puts "description: #{description}"

    self.title = title
    self.description = description
    self.save
  end

end
