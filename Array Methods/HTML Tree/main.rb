require_relative 'tree.rb'
require_relative 'traversal_tree.rb'

tree_html = Tree.new('<div class="container">
  <h1>Welcome!</h1>
  <div class="content">
    <p><span>Hello, world!</span></p>
    <p><span>Have a great day!</span></p>
  </div>
</div>
')

puts "\nSelect для дерева"
div_nodes = tree_html.select { |node| node.name == "div" }
puts div_nodes

puts "\n\nОбход в глубину"
tree_html.dfs.each do |element|
  puts "#{element}"
end

puts "\n\nОбход в ширину"
tree_html.bfs.each do |element|
  puts "#{element}"
end

