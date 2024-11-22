require_relative 'tree.rb'

tree_html = Tree.new('<div class="container">
  <h1>Welcome!</h1>
  <div class="content">
    <p><span>Hello, world!</span></p>
    <p><span>Have a great day!</span></p>
  </div>
</div>
')
puts tree_html.inspect

