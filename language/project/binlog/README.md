## Binary Log System Exercise
Your task is to implement a binary logging system that writes messages to a file in a specific binary format. The system should allow writing new messages and retrieving them based on specific criteria.

### Message Format
Each log message in the file should be structured as follows:

- Total Length (2 bytes, big-endian): represents the total length of the message including all fields
- Timestamp (4 bytes, big-endian): Unix timestamp
- Severity (1 byte): numeric code representing message severity
- Data (variable length): the actual message content

### Required Modules

- struct: for binary data packing/unpacking
- time: for timestamp handling
- enum: for severity level definitions
- dataclasses (optional): for message class implementation

### Implementation Requirements
#### 1. Create a LogSeverity Enum
Define severity levels:

DEBUG = 1  
INFO = 2  
WARNING = 3  
ERROR = 4  
CRITICAL = 5  

#### 2. Implement LogMessage Class
Create a class that represents a single log message with:
- Properties for msg_length, timestamp, severity, and message data
- Method to pack the message into bytes
- Method to unpack bytes into a message
- String representation method

#### 3. Implement Binary Logger
Create a class that handles file operations with methods to:

- Write a new message to the end of the file
- Read messages one by one
- Search for messages by:
  - Severity level
  - Timestamp range
  - Combination of severity and timestamp


#### 4. Error Handling Requirements

- Handle file not found
- Handle corrupted message format
- Validate severity levels
- Validate message length

### Testing Requirements
Create test cases for:

- Writing and reading single messages
- Writing and reading multiple messages
- Searching by different criteria
- Error conditions
- Edge cases (empty messages, maximum length messages)

### Bonus Challenges

- Implement message compression
- Add message categories
- Create an index file for faster searching
- Implement message encryption
- Add support for message deletion

### Deliverables

- log_severity.py: Enum definitions
- log_message.py: LogMessage class implementation
- binary_logger.py: Binary logging implementation
- test_binary_logger.py: Test suite
- Documentation explaining your implementation choices


### Hints

- - do not supply a total msg length, your LogMessage should compute it itself
- You can use ContextManager in your BinaryLogger class.
  (you should add __enter__()  and __exit__()  methods, open the file in __enter__ and close in __exit__)
  so that you could:

with BinaryLogger('dump1.log') as bfl:
    ...
    msg1 = LogMessage( ...)
    bfl.append_log(msg1)
 
- plan your BinaryLogger methods:
    - append_log

- You can add a default time in LogMessage, so that if you don't supply that the class will create it itself
  (so data and severity is all that is needed)