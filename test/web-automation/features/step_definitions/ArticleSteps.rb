When("I create an article with title {string} and description {string}") do |title, description|
  on ArticlePage do |page|
    page.create_update_article(title, description)
  end
end

When("I edit an article with title {string} and description {string}") do |title, description|
  on ArticlePage do |page|
    page.create_update_article(title, description)
  end
end
