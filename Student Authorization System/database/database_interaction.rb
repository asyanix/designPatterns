require 'pg'

class DB_connection
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    self.connection = self.connect
  end

  def connect(dbname = "Students", user = "postgres", password = "postpass", host = "localhost", port = 5432)
    raise "Connection already established" if self.connection
    begin
      return PG.connect(
        dbname: dbname,
        user: user,
        password: password,
        host: host,
        port: port
      )
    rescue PG::Error => ex
        raise "Connection failed: #{ex.message}"
    end
  end

  def connected?
    return !connection.nil?
  end

  def execute_query(query)
    raise "Establish the connection first" if !connected?
    begin
      connection.exec(query)
    rescue PG::Error => ex
      raise "Query execution failed: #{ex.message}"
    end
  end

  def close_connection()
    raise "No connection to close" if !connected?
    begin
      self.connection.close
      self.connection = nil
    rescue PG::Error => ex
      raise "Failed to close connection: #{e.message}"
    end
  end

  private
  attr_accessor :connection
  @instance = nil
end