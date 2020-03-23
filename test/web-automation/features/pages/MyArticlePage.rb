class MyArticlePage
  include PageObject

  link(:create_article, :id => "create-article")
  link(:edit_article, :class => "edit-article")
  link(:delete_article, :class => "delete-article")

end
