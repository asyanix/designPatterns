require_relative 'tree.rb'

tree_html = Tree.new('<div class="container">
  <h1>Welcome!</h1>
  <div class="content">
    <p><span>Hello, world!</span></p>
    <p><span>Have a great day!</span></p>
  </div>
</div>
')

puts 'Обход в глубину'
tree_html.dfs.each do |element|
  puts "#{element}"
end

puts "\nОбход в ширину"
tree_html.bfs.each do |element|
  puts "#{element}"
end

