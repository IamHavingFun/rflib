### RFLIB 3.0.1

Package ID: 04t3h000004bh4IAAQ
Package Alias: RFLIB@3.0.1-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004bh4IAAQ

-   [Issue #41](https://github.com/j-fischer/rflib/issues/41) - Renamed the rflib_Log_Archive__b Big Object to rflib_Logs_Archive__c (better than rflib_Log_Archive2__c) in order to change the index
-   Fixed issue with "Disconnect" not being displayed in button label 

IMPORTANT: The rflib_Log_Archive__b will be flagged for deletion but not physically deleted. Please remove manually at your earliest convenience. 

### RFLIB 3.0.0

Package ID: DEPRECATED
Package Alias: RFLIB@3.0.0-1
Install link: N/A

-   Added support for logging to Log Archive (Big Object), which can be queried through Log Monitor
-   Log Monitor: Fixed issue when the connection would not re-establish after switching to Permission Explorer
-   Permission Explorer: Permission Type button now changes the label to the actively selected type

### RFLIB 2.8.0

Package ID: 04t3h000004RdhnAAC
Package Alias: RFLIB@2.8.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004RdhnAAC

-   Permission Explorer: Added Export to CSV button to Permission Explorer

### RFLIB-TF 1.3.1

Package ID: 04t3h000004RdhiAAC
Package Alias: RFLIB-TF@1.3.1-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004RdhiAAC

-   [Issue #35](https://github.com/j-fischer/rflib/issues/35) - Updated TriggerManager to track active handlers on a per Object and Trigger Operation basis, invoking onConsecutive run only if the particular handler did complete the handling of an event previously

### RFLIB 2.7.0

Package ID: 04t3h000004RdZsAAK
Package Alias: RFLIB@2.7.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004RdZsAAK

-   Permission Explorer: Optimized FLS query to return Fields stripped of their object name when using the REST API
-   Permission Explorer: Added new component to resolve profile name by User Id to simplify entering of filter criteria
-   Log Monitor: Added profile to the display of the user details in the Log Event Viewer
-   Log Monitor: Fixed issue in the Ops Center Access Permission Set, which prevented non-admin users from receiving Log Events

### RFLIB 2.6.0

Package ID: 04t3h000004RdLTAA0
Package Alias: RFLIB@2.6.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004RdLTAA0

-   Added support for querying over 50,000 permissions in Permission Explorer using the REST API
-   Moved MockQueryExecutor from RFLIB-FS to RFLIB package

### RFLIB-TF 1.3.0

Package ID: 04t3h000004RdLOAA0
Package Alias: RFLIB-TF@1.3.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004RdLOAA0

-   [Issue #31](https://github.com/j-fischer/rflib/issues/31) - Improved error handling if there are invalid trigger handler names in the configuration
-   [Issue #30](https://github.com/j-fischer/rflib/issues/30) - Improved `rflib_MockTriggerConfigQueryLocator` to allow for setting multiple object handlers in a trigger unit test class

### RFLIB 2.5.0

Package ID: 04t3h000004Rd7uAAC
Package Alias: RFLIB@2.5.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004Rd7uAAC

-   Added initial version of Permission Explorer
-   Fixed issue with navigation buttons in Log Monitor getting confused when searching for Log Events

### RFLIB-TF 1.2.0

Package ID: 04t3h000004Rd1IAAS
Package Alias: RFLIB-TF@1.2.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004Rd1IAAS

-   Replaced queries for Custom Metadata Type `rflib_Trigger_Configuration__mdt` with the new Apex API methods

### RFLIB-FS 1.2.0

Package ID: 04t3h000004RczqAAC
Package Alias: RFLIB-FS@1.2.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004RczqAAC

-   Replaced queries for Custom Metadata Type `rflib_Feature_Switch__mdt` with the new Apex API methods
-   Changed log levels of some framework log messages from DEBUG to TRACE

### RFLIB 2.4.0

Package ID: 04t3h000004RczlAAC
Package Alias: RFLIB@2.4.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004RczlAAC

-   Replaced queries for Custom Metadata Type `rflib_Global_Setting__mdt` with the new Apex API methods

### RFLIB 2.3.0

Package ID: 04t3h000004jqfnAAA
Package Alias: RFLIB@2.3.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jqfnAAA

-   Implemented finalizer interface support for Queueables
-   Provided the ability to mask text within the collected log messages when publishing a log event

### RFLIB-FS 1.1.0

Package ID: 04t3h000004jqXEAAY
Package Alias: RFLIB-FS@1.1.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jqXEAAY

-   Added new feature switch scope type called "Public Group" which allows for overwrites using direct public group memberships

### RFLIB-TF 1.1.0

Package ID: 04t3h000004jq2OAAQ
Package Alias: RFLIB-TF@1.1.0-3
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jq2OAAQ

-   All metadata was upgraded to API version 50.0
-   Added Custom Permission to allow to bypass all triggers

### RFLIB-FS 1.0.2

Package ID: 04t3h000004jpyMAAQ
Package Alias: RFLIB-FS@1.0.2-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jpyMAAQ

-   All metadata was upgraded to API version 50.0

### RFLIB 2.2.0

Package ID: 04t3h000004jpwzAAA
Package Alias: RFLIB@2.2.0-2
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jpwzAAA

-   All metadata was upgraded to API version 50.0
-   Added input field for User filter Log Monitor
-   Introduced the Salesforce Request ID into the logging framework
-   Added Salesforce Request ID to TraceID token to make it completely unique
-   Added Log Timer actions support for Flow
-   Updated unit tests for Winter 21 release where new dedicated limits for publishing platform events immediately are introduced. See https://releasenotes.docs.salesforce.com/en-us/winter21/release-notes/rn_platform_events_publish_immediate_limit.htm?edition=&impact=

### RFLIB-TF 1.0.1

Package ID: 04t3h000004jnfBAAQ
Package Alias: RFLIB-TF@1.0.1-3
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jnfBAAQ

-   Fixed issue with rflib_MockTriggerConfigQueryLocator that would fail tests for regular custom or standard objects
-   Updated project dependency for RFLIB to version 2.1

### RFLIB 2.1.0

Package ID: 04t3h000004jnf6AAA
Package Alias: RFLIB@2.1.0-3
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jnf6AAA

-   Introduced Log Timer for LWC, Aura, and Apex to add a log statement including the duration of the timer
-   Added new custom setting to set the log level for when to flush log statements after a Log Event is published, default level is NONE
-   Fixed bug where the Log Reporting Level did not allow for NONE as a valid value

### RFLIB-FS 1.0.1

Package ID: 04t3h000004jmovAAA
Package Alias: RFLIB-FS@1.0.1-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jmovAAA

-   Added rflib_Enable_Client_Feature_Switches permission set (moved from RFLIB package)

### RFLIB 2.0.1

Package ID: 04t3h000004jmoqAAA
Package Alias: RFLIB@2.0.1-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004jmoqAAA

-   Removed rflib_Enable_Client_Feature_Switches permission set from package (to be added to RFLIB-FS)

### RFLIB-TF 1.0.0

Package ID: 04t3h000004bcWpAAI
Package Alias: RFLIB-TF@1.0.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004bcWpAAI

-   RFLLB-TF 1.0.0 contains the Trigger Framework, which depends on RFLIB 2.0.0 and RFLIB-FS 1.0.0
-   All metadata was upgrade to API version 49.0

### RFLIB-FS 1.0.0

Package ID: 04t3h000004bcXJAAY
Package Alias: RFLIB-FS@1.0.0-2
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004bcXJAAY

-   RFLIB-FS 1.0.0 contains the Feature Switch framework and depends on RFLIB 2.0.0
-   All metadata was upgrade to API version 49.0

### RFLIB 2.0.0

Package ID: 04t3h000004bcWfAAI
Package Alias: RFLIB@2.0.0-4
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004bcWfAAI

-   RFLIB 2.0.0 contains the core logging framework. The log event email handler got converted into a Invocable Action, which is used by a Platform Event triggered Flow to send out the email message based on the configuration in the Logger Settings
-   RFLIB-FS 1.0.0 contains the Feature Switch framework and depends on RFLIB 2.0.0
-   RFLLB-TF 1.0.0 contains the Trigger Framework, which depends on RFLIB 2.0.0 and RFLIB-FS 1.0.0
-   All metadata was upgrade to API version 49.0

### RFLIB 1.0.1

Package ID: 04t3h000004bbNiAAI
Package Alias: RFLIB@1.0.1-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004bbNiAAI

-   Fixed issue in rflibLogger.setConfig where new server and console log levels failed to take effect
-   Fixed issue in rflibFeatureSwitch where a failed request to the Apex action would return an undefined exception instead of the server error
-   Added LWC unit tests
-   Build script improvements

### RFLIB 1.0.0

Package ID: 04t3h000002rTGPAA2
Package Alias: RFLIB@1.0.0-1
Install link: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000002rTGPAA2

-   **May 2020** - Bug fixes
-   **Apr 2020** - Added TRACE log level, rebranding, multiple enhancements to the core framework including log batching
-   **Mar 2020** - Enhanced email reporting and introduced log batching
-   **Feb 2020** - Added application to review log events for the last 24 hours as well as in real-time on a dashboard
-   **Jan 2020** - Added Feature Switches implementation including switch to suspend all triggers
-   **Dec 2019** - Added `HttpRequest` wrapper and Trace ID implementation
-   **Nov 2019** - Initial release with Trigger pattern, LWC/LC logger, and Apex logger
