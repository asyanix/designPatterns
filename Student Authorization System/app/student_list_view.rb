require 'fox16'
require_relative '../models/data/data_list_student_short.rb'
require_relative '../entities/student.rb'
require_relative '../entities/student_short.rb'
require_relative '../models/data/data_table.rb'

include Fox

class Student_list_view < FXMainWindow
  private attr_accessor :filters, :table, :prev_button, :next_button, :total_pages, :items_per_page, :page_index, :current_page, :delete_button, :edit_button

  def initialize(app)
    super(app, "Students", width: 1200, height: 768)
    self.filters = {}
    self.current_page = 1
    self.items_per_page = 20
    self.total_pages = 0

    main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL)
    filter_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 220, padding: 15)
    setup_filter_segment(filter_segment)

    table_segment = FXVerticalFrame.new(main_frame, LAYOUT_FILL, padding: 10)
    setup_table_segment(table_segment)

    crud_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 130, padding: 10)
    setup_crud_segment(crud_segment)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  private 

  # Создание области фильтрации
  def setup_filter_segment(parent)
    FXLabel.new(parent, "Filtering")
    FXLabel.new(parent, "Surname and initials:")
    initials_tbx = FXTextField.new(parent, 25)
    self.filters['name'] = { text_field: initials_tbx }
    add_filter_row(parent, "Git:")
    add_filter_row(parent, "Email:")
    add_filter_row(parent, "Phone:")
    add_filter_row(parent, "Telegram:")
  end

  # Создание области с таблицой студентов 
  def setup_table_segment(parent)
    self.table = FXTable.new(parent, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.setTableSize(self.items_per_page, 4)
    self.table.setColumnWidth(0, 30)
    (1..3).each {|col| self.table.setColumnWidth(col, 220)}
    self.table.rowHeaderWidth = 0

    self.table.connect(SEL_COMMAND) do |_, _, pos|
      if pos.row == 0 && pos.col == 1
        sort_table_by_column(pos.col)
      end

      if pos.col == 0
        self.table.selectRow(pos.row)
      end
    end

    navigation_segment = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    self.prev_button = FXButton.new(navigation_segment, "<-", opts: LAYOUT_LEFT | BUTTON_NORMAL)
    self.page_index = FXButton.new(navigation_segment, "1", opts: LAYOUT_CENTER_X)
    self.next_button = FXButton.new(navigation_segment, "->", opts: LAYOUT_RIGHT | BUTTON_NORMAL)
    self.prev_button.connect(SEL_COMMAND) {change_page(-1)}
    self.next_button.connect(SEL_COMMAND) {change_page(1)}

    self.table.setItemText(0, 0, "№")
    self.table.setItemText(0, 1, "Surname and initials")
    self.table.setItemText(0, 2, "Git")
    self.table.setItemText(0, 3, "Contact")

    self.table.setItemText(1, 0, "1")
    self.table.setItemText(1, 1, "Cheuzh A.A.")
    self.table.setItemText(1, 2, "asyanix")
    self.table.setItemText(1, 3, "email: asyanix@gmail.com")

    self.table.setItemText(2, 0, "2")
    self.table.setItemText(2, 1, "Ponomar D. S.")
    self.table.setItemText(2, 2, "pnmr3000")
    self.table.setItemText(2, 3, "email: pnmr3000@gmail.com")

    self.table.setItemText(3, 0, "3")
    self.table.setItemText(3, 1, "Ivanchenko P. A.")
    self.table.setItemText(3, 2, "eatdetey")
    self.table.setItemText(3, 3, "email: eatdetey@gmail.com")
  end

  # Создание области управления
  def setup_crud_segment(parent)
    add_button = FXButton.new(parent, "Add", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    self.delete_button = FXButton.new(parent, "Delete", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    self.edit_button = FXButton.new(parent, "Change", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    refresh_button = FXButton.new(parent, "Update", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    self.table.connect(SEL_CHANGED) {update_buttons_state}
  end

  # Добавление выбора наличия или отсутствия фильтра
  def add_filter_row(parent, label)
    FXLabel.new(parent, label)
    cbx = FXComboBox.new(parent, 3, opts: LAYOUT_FIX_WIDTH | COMBOBOX_STATIC, width: 190)
    cbx.numVisible = 3
    cbx.appendItem("No matter")
    cbx.appendItem("Yes")
    cbx.appendItem("No")
    search_tbx = FXTextField.new(parent, 25)
    search_tbx.visible = false
    self.filters[label] = { combo_box: cbx, text_field: search_tbx }
    cbx.connect(SEL_COMMAND) do
      search_tbx.visible = (cbx.currentItem == 1)
      parent.recalc
    end
  end

  # Обновление доступ к кнопкам CRUD в зависимости от выбранных строк
  def update_buttons_state
    selected_rows = (0...self.table.numRows).select {|row| self.table.rowSelected?(row)}
    self.delete_button.enabled = !selected_rows.empty?
    self.edit_button.enabled = (selected_rows.size == 1)
  end

  # Переключение страниц
  def change_page(offset)
    new_page = self.current_page + offset
    return if new_page < 1 || new_page > self.total_pages
    self.current_page = new_page
  end

  # Заполнение таблицы
  def populate_table(data_table)
    clear_table
    (1...data_table.row_count).each do |row|
      (0...data_table.column_count).each do |col|
        self.table.setItemText(row, col, data_table.get_by_index(row, col).to_s)
      end
    end
  end

  # Получение данных из таблицы
  def read_table_from_view
    table = []
    (1...self.table.numRows).each do |row|
      row_data = []
      (0...self.table.numColumns).each do |col|
        row_data << self.table.getItemText(row, col)
      end
      break if row_data.all? {|attribute| attribute  == ""}
      
      table << row_data
    end
    return table
  end

  # Сортировка по указанному столбцу
  def sort_table_by_column(col_ix)
    table = read_table_from_view
    return if table.empty? 

    sorted_table = table.sort_by { |row| row[col_ix] }

    sorted_table.each_with_index do |row, i|
      row.each_with_index do |value, j|
        self.table.setItemText(i + 1, j, value)
      end
    end
  end

  # Очистка таблицы
  def clear_table
    (1...self.table.numRows).each do |row|
      (0...self.table.numColumns).each do |col|
        self.table.setItemText(row, col, "")
      end
    end
  end
end
