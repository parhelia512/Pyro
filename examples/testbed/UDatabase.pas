{===============================================================================
  ___
 | _ \_  _ _ _ ___
 |  _/ || | '_/ _ \
 |_|  \_, |_| \___/
      |__/
   Game Library™

 Copyright © 2024-present tinyBigGAMES™ LLC
 All Rights Reserved.

 https://github.com/tinyBigGAMES/Pyro
===============================================================================}

unit UDatabase;

interface

uses
  System.SysUtils,
  Pyro,
  UCommon;

procedure RemoteDb01();

implementation

{
  RemoteDB - PHP Interface for Remote MySQL Database (in 'src/remotedb' folder)

  1. If you are using cPanel, ensure that both php_mysql and pdo_mysql
     extensions are enabled.
  2. Update the config.php file to set your MySQL configuration.
  3. In the Config class within index.php, adjust the path to correctly
     reference your config.php script.
  4. Ensure that config.php is stored outside of the publicly accessible HTTP
     directory for security reasons.

-----------------------------------------------------------------------------

  Explanation of SQL Static Macros (&text) and Dynamic Parameters (:text):

  1. SQL Static Macros (&text):
     - Purpose: Static macros are placeholders in your SQL query that are
       replaced with fixed values or strings at the time the SQL text is
       prepared.
     - How it works: When you use &text in your SQL statement, it acts as a
       macro that is replaced with a specific value or table name before the
       query is executed. This is typically used for SQL elements that don't
       change per execution, like table names or field names.
     - Example: If you have 'SELECT * FROM &table;' in your SQL text, and you
       set &table to 'users', the final SQL executed would be
       'SELECT * FROM users;'.
     - Analogy: Think of it like a "find and replace" that happens before the
       query runs.

  2. SQL Dynamic Parameters (:text):
     - Purpose: Dynamic parameters are used to securely insert variable data
       into SQL queries at runtime. They are typically used for values that
       can change, such as user input or variable data, and are often used to
       prevent SQL injection.
     - How it works: When you use :text in your SQL statement, it acts as a
       placeholder that will be dynamically replaced with an actual value at
       runtime. The value is passed separately from the SQL query, allowing
       for secure and flexible data handling.
     - Example: If you have 'SELECT * FROM users WHERE id = :userId;' in your
       SQL text, and you bind :userId to the value '42', the final SQL
       executed would be 'SELECT * FROM users WHERE id = 42;'.
     - Analogy: Think of it as a variable that gets its value just before the
       SQL query is run, making it possible to execute the same query with
       different data multiple times.
}

procedure RemoteDb01();
const
  // Remote database connection details.
  CDbURL = 'https://tinybiggames.com/remotedb/pgl-examples';      // URL of the cloud database.
  CDbApiKey = 'c91c8b1561fc4890a216e2a550c2e5de';                 // API key for accessing the cloud database.
  CDbName = 'testbed';                                            // Name of the database.
  CDbTable = 'game1';                                             // Name of the table in the database.

var
  LRemoteDb: TPyRemoteDb;            // Instance of TPyRemoteDb to handle database operations
  LCount: Integer;                   // Variable to store the number of records retrieved
  I: Integer;                        // Loop counter for iterating through records
  LName, LLevel, LScore, LSkill,     // Variables to hold individual field values from each record
  LDuration, LLocation: string;
begin
  // Set the console title for the application window
  PyConsole.SetTitle('Pyro: RemoteDb #01');

  // Create an remote db instance to manage the connection to the database
  LRemoteDb := TPyRemoteDb.Create();
  try
    // Setup the CloudDB connection with the specified URL, API key, and database name
    LRemoteDb.Setup(CDbURL, CDbApiKey, CDbName);

    // Set the SQL query text to select all records from the specified table
    LRemoteDb.SetSQLText('SELECT * FROM &table;');

    // Set a macro to replace the placeholder "&table" with the actual table name
    LRemoteDb.SetMacro('table', CDbTable);

    // Execute the SQL query and check if it returns any records
    if LRemoteDb.Execute() then
    begin
      // Retrieve the count of records returned by the query
      LCount := LRemoteDb.RecordCount();
      PyConsole.PrintLn(); // Print a blank line for spacing

      // Print the title of the table
      PyConsole.PrintLn();
      PyConsole.PrintLn('%s%s', [PyCSIFGMagenta, '                          --= H I G H S C O R E S =--']);

      // Print the table header with column names
      PyConsole.PrintLn('-------------------------------------------------------------------------------');
      PyConsole.PrintLn('| %-20s | %-5s | %-6s | %-10s | %-8s | %-10s |', ['Name', 'Level', 'Score', 'Skill', 'Duration', 'Location']);
      PyConsole.PrintLn('-------------------------------------------------------------------------------');

      // Iterate through each record and print the fields in a formatted table row
      for I := 0 to LCount-1 do
      begin
        // Retrieve and store each field value from the current record
        LName := LRemoteDb.GetField(I, 'name');
        LLevel := LRemoteDb.GetField(I, 'level');
        LScore := LRemoteDb.GetField(I, 'score');
        LSkill := LRemoteDb.GetField(I, 'skill');
        LDuration := LRemoteDb.GetField(I, 'duration');
        LLocation := LRemoteDb.GetField(I, 'location');

        // Print the field values in a formatted table row
        PyConsole.PrintLn('| %-20s | %-5s | %-6s | %-10s | %-8s | %-10s |', [LName, LLevel, LScore, LSkill, LDuration, LLocation]);
      end;

      // Print the table footer to close off the table
      PyConsole.PrintLn('-------------------------------------------------------------------------------');
    end;
  finally
    // Free the ICloudDb instance to release resources
    LRemoteDb.Free();
  end;
end;

end.
