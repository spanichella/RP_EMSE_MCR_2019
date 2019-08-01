# TestSmellDescriber-ReplicationPackage

1) "1_Emails-Sent-To-Participants" contains:

    1. Email-WS1.docx and Email-WS1.pdf  
    2. Email-WS2.docx and Email-WS2.pdf
    
     As explained in the paper the experiment was conducted offline, i.e., 
     we have send via email to the participants the required experimental material 
     with instructions about the tasks to perform. During the tasks the participants were guided via
     Google Forms (shared in the above e-mail), this also to collect information about the performed activities. 
     As reported in the emails we send to each participant  an experiment package composed by (i) a 
     pre-questionnaire (to collect information about the profile and experience of each participant), 
     (ii) surveys with instructions and materials to perform the tasks, and (iii) a post-questionnaire. 
     Before the  study, we explained to the participants the expected tasks:  
     two maintenance and evolution tasks, each involving two pairs of Java and test classes. 


2) "2_Information-about-smells-and-refactoring-operations" contains, 
    as reported in the paper, to facilitate the two tasks "we provided 
    the document <"Test Smells & Refactorings.pdf"> describing the notion of a test/code smells, the types
     of smells potentially affecting test cases and the recommended refactoring operations to remove them.

3) "3_Information-about-the-smells-detected" contains:
   (a) "Summary for apache-ofbiz-16.11.04" contains name of all the smelly classes and name of the smell(s) each Java/test
       class has.
   (b) "Summary for at method level apache-ofbiz-16.11.04" contains name of the classes with name of the smelly 
        methods	and name of the smell
	    each method is suffering with.
	
4) "4_Surveys-Sent-To-Participants" contains
    the 4 surveys (in pdf format) performed by the participants.

		1. Pre-Task TSD survey.pdf includes Brief Introduction of this experiment and question related to basic information of participants.
		2. Task 1 TSD survey.pdf includes testing task 1, additional information to perform the task 1 and questions related to the task 1.
		3. Task 2 TSD Survey.pdf includes testing task 2, additional information to perform the task 2 and questions related to the task 2.
		4. Post-Task TSD survey.pdf includes questions regarding the TestSmellDescriber tools performance and usefulness, provides opportunity
		to suggest modifications and questions related to consiceness, completness and precision of the whole survey and tasks.
	
5) "5_Templates-defined-and-used-to-generate-the-summaries".
    As reported in the paper, "by leveraging the SWUM model TestSmellDescriber generates descriptions at 
    different levels of abstraction, as reported in Figure 1 of the paper:
    - a short and long method description, 
    - a short and long refactoring description, 
    - and a quantitative description of the smell in the context of the whole project. 
    The descriptions are generated, as done in previous work, with natural "language templates" that are 
    augmented by the information that is gathered from the smell detection process. 

6) "6_Working-Dataset" contains the two workspaces we gave to the participants for executing the tasks.
   
	a) “Workspace1-Sent-To-Participants” contains the java projects we selected for our experiment;
	    in this case, we have selected 2 target classes, needs to be smell free, one class without 
	    summaries and another with summaries
  	b)  “Workspace2-Sent-To-Participants” contains the java projects we selected for our experiment;
	     in this case, we have selected 2 target classes, needs to be smell free, one class without 
	     summaries and another with summaries
    c) It is important to mention the test/Java classes used in the study are are located in the 
        workspaces in the following relative paths:
		1) ...\src\framework\base\src\main\java\org\apache\ofbiz\base\util\string\test\FlexibleStringExpanderTests.java
		2) ...\src\framework\base\src\main\java\org\apache\ofbiz\base\util\test\TimeDurationTests.java
		3)  ...\src\framework\base\src\main\java\org\apache\ofbiz\base\util\string\FlexibleStringExpander.java
		4)  ...\src\framework\base\src\main\java\org\apache\ofbiz\base\util\TimeDuration.java
		5) ...\src\framework\base\src\main\java\org\apache\ofbiz\base\util\collections\test\FlexibleMapAccessorTests.java
		6) ...\src\framework\base\src\main\java\org\apache\ofbiz\base\util\cache\test\UtilCacheTests.java
		7)...\src\framework\base\src\main\java\org\apache\ofbiz\base\util\collections\FlexibleStringExpander.java
		8) ...\src\framework\base\src\main\java\org\apache\ofbiz\base\util\cache\UtilCache.java
       

7) "7_Results-of-the-questionnaires" contains a folder "data-analysis" containing
   - "data" folder which contains: 
   			- in "figs" several  figures about the main results achieved (some of them used in the paper).
   			- the file "full_results-testsmelldescriber-anonymized.csv" reporting all results
   			  of the involved study participants. It was used to compute the statistics reported in the paper by using the 
   			  R script which is in the folder "R-script" (explained later in the readme file).
   - "R-script"  folder which contains
   			- "analysis.R" the script files used to computed all statistics explained in section study
   			  and reported in the papers. The script automatically generates the figures in the folder 
   			  "data/figs". 
   - "summary - Post-Task TSD Survey.pdf" - It reports the summary of results of the post-experiment questionnaires
   - "summary - Pre-Experiment TSD Survey.pdf" -  It reports the summary of results of the pre-experiment questionnaires
   - "summary---Task1-Survey.pdf" - It reports the summary of results of the  of the post-task questionnaire
   - "summary---Task2-Survey.pdf" - It reports the summary of results of the post-task questionnaire
   - "tasks-participants" contains the information the participants provided us about the performed changes.

8) "8_TestSmellDescriber-research-prototype" contains the
   prototypical version of TestSmellDescriber we used to generate the summaries 
   evaluated for the experiments. We provide information on how to use and run the tool
   on the provided data.