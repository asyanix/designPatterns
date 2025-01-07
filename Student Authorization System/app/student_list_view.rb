require 'fox16'
require_relative '../models/data/data_list_student_short.rb'
require_relative '../entities/student.rb'
require_relative '../entities/student_short.rb'
require_relative '../models/data/data_table.rb'
require_relative 'student_list_controller.rb'

include Fox

class Student_list_view < FXMainWindow
  private attr_accessor :filters, :table, :prev_button, :next_button, :total_pages,
  :page_index, :delete_button, :edit_button, :controller
  attr_accessor :current_page, :items_per_page

  def initialize(app)
    super(app, "Students", width: 1200, height: 768)

    self.controller = Student_list_controller.new(self)
    self.filters = {}
    self.current_page = 1
    self.items_per_page = 6
    self.total_pages = 0

    main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL)
    filter_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 220, padding: 15)
    setup_filter_segment(filter_segment)

    table_segment = FXVerticalFrame.new(main_frame, LAYOUT_FILL, padding: 10)
    setup_table_segment(table_segment)

    crud_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 130, padding: 10)
    setup_crud_segment(crud_segment)

    self.current_page = 1

    # Объект view вызывает метод refresh_data у контроллера
    self.controller.refresh_data
    update_buttons_state
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  # Устанавливаем колонки таблицы и кол-во страниц
  def set_table_params(column_names, logs_count)
    column_names.each_with_index do |name, index|
        self.table.setItemText(0, index, name)
    end
    puts("Logs_count: #{logs_count}")
    puts("Items_per_page: #{self.items_per_page}")
    self.total_pages = (logs_count / (self.items_per_page - 1).to_f).ceil
    puts("Total_pages: #{self.total_pages}")
    self.page_index.text = "#{self.current_page} out of #{self.total_pages}"
  end

  # Заполнение таблицы
  def set_table_data(data_table)
    clear_table
    (1...data_table.row_count).each do |row|
      (0...data_table.column_count).each do |col|
        self.table.setItemText(row, col, data_table.get_by_index(row, col).to_s)
      end
    end
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
        self.controller.sort_table_by_column
        self.controller.refresh_data
      end

      if pos.col == 0
        self.table.selectRow(pos.row)
      end

      update_buttons_state
    end

    navigation_segment = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    self.prev_button = FXButton.new(navigation_segment, "<-", opts: LAYOUT_LEFT | BUTTON_NORMAL)
    self.page_index = FXButton.new(navigation_segment, "1", opts: LAYOUT_CENTER_X)
    self.next_button = FXButton.new(navigation_segment, "->", opts: LAYOUT_RIGHT | BUTTON_NORMAL)
    self.prev_button.connect(SEL_COMMAND) {change_page(-1)}
    self.next_button.connect(SEL_COMMAND) {change_page(1)}
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
    self.controller.refresh_data
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

  # Очистка таблицы
  def clear_table
    (1...self.table.numRows).each do |row|
      (0...self.table.numColumns).each do |col|
        self.table.setItemText(row, col, "")
      end
    end
  end
end
