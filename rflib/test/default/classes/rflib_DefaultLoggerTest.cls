/*
 * Copyright (c) 2021 Johannes Fischer <fischer.jh@gmail.com>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name "RFLIB", the name of the copyright holder, nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
@isTest
@SuppressWarnings('PMD.ClassNamingConventions')
public class rflib_DefaultLoggerTest {

  private static final String ABORT_TRANSACTION = 'Abort Transaction';

  private static final String AFTER_INSERT = TriggerOperation.AFTER_INSERT.name();
  private static final String OBJECT_TYPE_NAME = rflib_Log_Event__e.SObjectType.getDescribe().getName();

  @isTest
  public static void testDefaultBehaviour() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testDefaultBehaviour');

    logger.trace('trace statement to ignore');
    logger.info('first info statement');

    Integer i;
    for (i = 2; i < 101; i++) {
      logger.info('info statement ' + i);
    }

    logger.warn('warn statement');

    System.assert(loggerFactory.eventCapture.eventHasBeenPublished(), 'event should have been published');

    System.assert(loggerFactory.debugLogCapture.doesNotContainInAnyMessage('trace statement to ignore'), 'falsely contained trace statement to ignore');
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('first info statement'), 'debugLogger did not contain statement');
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('warn statement'), 'debugLogger did not contain statement');

    loggerFactory.debugLogCapture.clearCapturedLogs();

    logger.printLogs();

    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('Log statements reported by'), 'debugLogger did not contain header statement'); 
    System.assert(loggerFactory.debugLogCapture.doesNotContainInAnyMessage('first info statement'), 'debugLogger falsely contained statement');
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('warn statement'), 'debugLogger did not contain statement');

    logger.fatal('fatal log statement');

    System.assert(loggerFactory.eventCapture.eventHasBeenPublished(), 'event did not get published');
    System.assert(loggerFactory.eventCapture.doesNotContainInAnyMessage('first info statement'), 'event falsely contained statement');
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('warn statement'), 'event did not contain statement');
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('fatal log statement'), 'event did not contain statement');
  }

  @isTest
  public static void testSetLogCacheSize() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testSetLogCacheSize');

    logger.setLogCacheSize(3);

    logger.info('first info statement');

    Integer i;
    for (i = 2; i < 5; i++) {
      logger.info('info statement ' + i);
    }

    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('first info statement'), 'debugLogger did not contain statement');
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('info statement 4'), 'debugLogger did not contain statement');

    loggerFactory.debugLogCapture.clearCapturedLogs();
    logger.printLogs();

    System.assert(loggerFactory.debugLogCapture.doesNotContainInAnyMessage('first info statement'), 'debugLogger falsely contained statement');
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('info statement 4'), 'debugLogger did not contain statement');

    logger.fatal('fatal log statement');

    System.assert(loggerFactory.eventCapture.eventHasBeenPublished(), 'event did not get published');
    System.assert(loggerFactory.eventCapture.doesNotContainInAnyMessage('first info statement'), 'event falsely contained statement');
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('fatal log statement'), 'event did not contain statement');
  }

  @isTest
  public static void testSetSystemLoggingLevel() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testSetLogCacheSize');

    logger.trace('trace statement to ignore');
    System.assert(loggerFactory.debugLogCapture.doesNotContainInAnyMessage('trace statement to ignore'), 'falsely contained debug statement to ignore');

    logger.setSystemDebugLevel(rflib_LogLevel.TRACE);

    logger.trace('trace statement to include');
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('trace statement to include'), 'debugLogger did not contain statement');
  }

  @isTest
  public static void testSetReportingLogLevel() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testSetReportingLogLevel');

    logger.info('This statement should NOT trigger the publishing of an event');
    System.assert(loggerFactory.eventCapture.eventHasNotBeenPublished());

    logger.setReportingLogLevel(rflib_LogLevel.INFO);

    logger.info('This statement should trigger the publishing of an event');
    System.assert(loggerFactory.eventCapture.eventHasBeenPublished());
  }

  @isTest
  public static void testSetReportingLogLevel_LevelCannotBeSetBelowInfo() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testSetReportingLogLevel_LevelCannotBeSetBelowInfo');

    // This will set the actual log level to INFO
    logger.setReportingLogLevel(rflib_LogLevel.DEBUG);

    logger.debug('This statement should NOT trigger the publishing of an event');
    System.assert(loggerFactory.eventCapture.eventHasNotBeenPublished());

    logger.info('This statement should trigger the publishing of an event');
    System.assert(loggerFactory.eventCapture.eventHasBeenPublished());
  }

  @isTest
  public static void testExceedMaxMessageSize() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testSetReportingLogLevel');

    logger.setReportingLogLevel(rflib_LogLevel.ERROR);

    String longMessage = 'a';
    for (Integer i = 1; i < rflib_DefaultLogger.MAX_MESSAGE_SIZE; i++) {
      longMessage += 'b';
    }

    longMessage += 'c';

    logger.error(longMessage);

    System.assert(loggerFactory.eventCapture.eventHasBeenPublished());
    System.assert(loggerFactory.eventCapture.doesNotContainInAnyMessage('a'));
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('c'));
  }

  @isTest
  public static void testSetGeneralLogLevel() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testSetGeneralLogLevel');

    logger.trace('This statement should NOT be logged');
    System.assert(loggerFactory.eventCapture.eventHasNotBeenPublished());

    logger.setGeneralLogLevel(rflib_LogLevel.WARN);
    logger.setReportingLogLevel(rflib_LogLevel.ERROR);

    logger.error('This statement should be logged');
    System.assert(loggerFactory.eventCapture.eventHasBeenPublished());
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('This statement should be logged'));
    System.assert(loggerFactory.eventCapture.doesNotContainInAnyMessage('This statement should NOT be logged'));
  }

  @isTest
  public static void testMessageWithArgs() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testMessageWithArgs');

    logger.warn('warn message including {0}', new String[] { 'foo'});
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('warn message including foo'), 'debugLogger did not contain statement');
  }

  @isTest
  public static void testMessageWithException() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testMessageWithException');

    try {
      String.format(null, null);
    } catch (Exception ex) {
      logger.error('Caught an error', ex);
    } 
    
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('Argument cannot be null'), 'debugLogger did not contain exception message');
    System.assert(loggerFactory.debugLogCapture.containsInAnyMessage('rflib_DefaultLoggerTest'), 'debugLogger did not contain rflib_DefaultLoggerTest in stacktrace');
  }

  @isTest
  public static void testCreateFromCustomSettings() {
    insert new rflib_Logger_Settings__c(
      Log_Size__c = 50,
      System_Debug_Log_Level__c = 'WARN',
      Log_Event_Reporting_Level__c = 'ERROR',
      General_Log_Level__c = 'INFO',
      Org_Wide_Email_Sender_Address__c = 'foo@email.com',
      Batched_Log_Event_Reporting_Level__c = 'NONE'
    );

    System.assert(rflib_DefaultLogger.createFromCustomSettings('logger') != null);
  }

  @isTest
  public static void testCreate() {
    System.assert(rflib_DefaultLogger.create('logger') != null);
  }

  @IsTest
  private static void testSyncPlatformEventPublisher() {
    rflib_Logger logger = new rflib_DefaultLogger(
      new rflib_DefaultLogger.PlatformEventPublisher(), 
      new rflib_DefaultLogger.SystemDebugLogger(), 
      'testSyncPlatformEventPublisher'
    );

    logger.info('This is a test message');

    Test.startTest();
    logger.reportLogs();
    System.assertEquals(1, Limits.getPublishImmediateDML());
    Test.stopTest();
  }

  @IsTest
  private static void testBatchPlatformEventPublisher() {
    rflib_Logger logger = new rflib_DefaultLogger(
      new rflib_DefaultLogger.BatchPlatformEventPublisher(), 
      new rflib_DefaultLogger.SystemDebugLogger(), 
      'testBatchPlatformEventPublisher'
    );
    
    Test.startTest();
    logger.info('This is a test message');
    logger.info('This is a test message');
    logger.reportLogs();
    System.assertEquals(0, Limits.getPublishImmediateDML());
    
    logger.publishBatchedLogEvents();
    System.assertEquals(1, Limits.getPublishImmediateDML());
    Test.stopTest();
  }

  @IsTest
  private static void testSetBatchReportingLogLevel() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testSetBatchReportingLogLevel');

    logger.setReportingLogLevel(rflib_LogLevel.INFO);
    logger.setBatchReportingLogLevel(rflib_LogLevel.INFO);
   
    Test.startTest();
    logger.info('This is a test message');
    logger.info('This is a test message');
    System.assertEquals(0, Limits.getPublishImmediateDML());
    
    logger.publishBatchedLogEvents();
    System.assertEquals(1, Limits.getPublishImmediateDML());
    Test.stopTest();
  }

  @IsTest
  private static void testFlushLogCacheLevel() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testFlushLogCacheLevel');

    logger.setReportingLogLevel(rflib_LogLevel.INFO);
    logger.setFlushLogCacheLevel(rflib_LogLevel.INFO);

    Test.startTest();
    System.assert(loggerFactory.eventCapture.eventHasNotBeenPublished());
    
    logger.info('message1');
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('message1'));
    
    logger.info('message2');
    System.assert(loggerFactory.eventCapture.doesNotContainInAnyMessage('message1'));
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('message2'));
    Test.stopTest();
  }

  @IsTest
  private static void testLogMasking() {
    List<rflib_Masking_Rule__mdt> rules = new List<rflib_Masking_Rule__mdt> {
      createRule('secret', '****'),
      createRule('[\\d\\d\\d-\\d\\d\\d-\\d\\d\\d]', '####')
    };
    rflib_StringUtil.allActiveMaskingRules = rules;

    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    rflib_Logger logger = loggerFactory.createLogger('testLogMasking');

    logger.setReportingLogLevel(rflib_LogLevel.ERROR);
    logger.setLogMaskingState(true);

    Test.startTest();
    System.assert(loggerFactory.eventCapture.eventHasNotBeenPublished());
    
    logger.info('This message contains a secret word');
    logger.info('The SSN is 123-456-789');
    logger.error('And then an error occurred');
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('message contains'));
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('word'));
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('****'));
    System.assert(loggerFactory.eventCapture.containsInAnyMessage('####'));
    System.assert(loggerFactory.eventCapture.doesNotContainInAnyMessage('secret'));
    System.assert(loggerFactory.eventCapture.doesNotContainInAnyMessage('123-456-789'));
    
    Test.stopTest();
  }

  @IsTest
  private static void testTruncatedContext() {
    rflib_MockLoggerFactory loggerFactory = new rflib_MockLoggerFactory();

    String context = '40+ Character Context > 012345678901234567890';
    rflib_Logger logger = loggerFactory.createLogger(context);

    logger.fatal('fatal log statement');

    System.assert(loggerFactory.eventCapture.containsInAnyMessage('fatal log statement'), 'event did not contain statement');

    System.assertEquals(context.substring(0, 40), loggerFactory.eventCapture.getEvent().Context__c);
    System.assert(loggerFactory.eventCapture.containsInAnyMessage(context), 'event did not contain truncated context');
    System.assert(loggerFactory.eventCapture.containsInAnyMessage(context), 'event did not contain truncated context');
  }

  private static rflib_Masking_Rule__mdt createRule(String target, String replacement) {
    return new rflib_Masking_Rule__mdt(
        Target__c = target,
        Target_Type__c = 'RegEx',
        Replacement__c = replacement,
        Is_Active__c = true,
        Order__c = 1
    );
  }

  public class DebugLogCapture implements rflib_DefaultLogger.DebugLogger {
    private final List<String> capturedLogMessages = new List<String>();
    
    public void debug(LoggingLevel level, String message) {
      capturedLogMessages.add(message);
    }

    public void clearCapturedLogs() {
      capturedLogMessages.clear();
    }

    public Boolean doesNotContainInAnyMessage(String substring) {
      for (String message : capturedLogMessages) {
        if (message.contains(substring)) {
          System.debug('Actual messages:\n' + String.join(capturedLogMessages, '\n'));
          return false;
        }
      }

      return true;
    }

    public Boolean containsInAnyMessage(String substring) {
      for (String message : capturedLogMessages) {
        if (message.contains(substring)) {
          return true;
        }
      }

      System.debug('Actual messages:\n' + String.join(capturedLogMessages, '\n'));
      return false;
    }
  }

  public class EventCapture implements rflib_DefaultLogger.EventPublisher {
    private rflib_Log_Event__e capturedEvent;

    public void publish(SObject event) {
      capturedEvent = (rflib_Log_Event__e) event;
    } 

    public Boolean eventHasNotBeenPublished() {
      return capturedEvent == null;
    }

    public Boolean eventHasBeenPublished() {
      return capturedEvent != null;
    }

    public Boolean doesNotContainInAnyMessage(String substring) {
      Boolean result = capturedEvent.Log_Messages__c.contains(substring);
      if (result) {
        System.debug('Actual event message:\n' + capturedEvent.Log_Messages__c);
      }
      return result == false;
    }

    public Boolean containsInAnyMessage(String substring) {
      Boolean result = capturedEvent.Log_Messages__c.contains(substring);
      if (!result) {
        System.debug('Actual event message:\n' + capturedEvent.Log_Messages__c);
      }
      return result;
    }
  }
}
