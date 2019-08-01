# Replication Package for the paper "An Empirical Investigation of Relevant Changes and Automation Needs in Modern Code Review"

## Structure
```
project_raw_data/
    gerrit_review_comments.csv
    gerrit_review_changes.csv

survey_raw_data/
    google_forms_survey.pdf
    google_forms_survey.csv

RQ1_taxonomy_mcr/
    RQ1_inception_phase/
        initial_taxonomy.pdf
        intermediate_taxonomy.pdf

    RQ1_definition_phase/
        Q1.2_evaluation_survey.csv
        cram_classified.csv
        cram.pdf

RQ2_automation_needs/
    Q2.1-Q2.5_evaluation_survey.xlsx
    Q2.6-Q2.7_evaluation_survey.xlsx
    Q2.1-Q2.7_question_index.csv
    
RQ3_automated_support/
    content explained in the README.md file located in "RQ3_automated_support/README.md"
```

## Contents of the Replication Package
---
**project-raw-data/** contains the data used for the creation of our taxonomies, it includes information about the ten open-source projects.
- `gerrit_review_comments.csv` - information about all in-line review comments used for this paper
- `gerrit_review_changes.csv` - information about all patches analyzed that contain the in-line comments


**survey_raw_data/** contains information about the survey conducted for the paper.
- `google_forms_survey.pdf` - the distributed *Google Forms* of our survey
- `google_forms_survey.csv` - all survey answers obtained from 52 survey participants

**RQ1_taxonomy_mcr/** contains information and data about the elicited taxonomies in our paper (RQ1).
- **RQ1_inception_phase/**
    - `initial_taxonomy.pdf` - initial taxonomy obtained in the inception phase of our paper
    - `intermediate_taxonomy.pdf` - intermediate taxonomy after integrating and merging the initial taxonomy with the one by Beller *et al* [1]
- **RQ1_definition_phase/**
    - `Q1.2_evaluation_survey.csv` - relevant survey feedback with additional taxonomy categories integrated into *CRAM*
    - `cram_classified.csv` - classified review comments (`gerrit_review_comments.csv`) into *CRAM*
    - `cram.pdf` - *CRAM* taxonomy

**RQ2_automation_needs/** contains the encoded evaluation of the survey question Q2.1-2.7 for RQ2
- `Q2.1-Q2.5_evaluation_survey.xlsx` - the encoded evaluation of the survey questions Q2.1-Q2.5 (used for the *Automation Needs* Section in the paper) and contains the following sheets:
    - **all Findings**: Very detailed findings matrix distilled from all answers concerning possible automated solutions or general possibilities to achieve automation in MCR. Every feedback was analyzed and decomposed into single findings. These findings are grouped, into categories of our Taxonomy of Code Changes in MCR (CRAM). Red represent in the feedback-text where the corresponding category was distilled from.
    - **unique Findings**: As one participant could mention the same categories/solutions in multiple feedbacks, the following matrix is cleaned of any duplication of participant answers. Multiple feedbacks containing the same information by one participant were removed, leaving only distinct occurances.
    - **aggregated by Solution**: Aggregated feeback clustered into abstracted solutions and the number of times participants mentioned the solution.
    - **aggregated by Taxonomy**: Aggregated feeback grouped by low-level categoried in CRAM.
- `Q2.6-Q2.7_evaluation_survey.xlsx` - the encoded evaluation of the survey questions Q2.6-Q2.7 (used for the *Automation Needs* Section in the paper) and contains the following sheets:
    - **all Findings**: Very detailed findings matrix distilled from all answers concerning possible techniques, approaches and data to achieve automation in MCR. Every feedback was analyzed and decomposed into single findings. These findings are grouped, into categories of our Taxonomy of Code Changes in MCR (CRAM). Red represent in the feedback-text where the corresponding category was distilled from.
    - **unique Findings**: As one participant could mention the same categories/solutions in multiple feedbacks, the following matrix is cleaned of any duplication of participant answers. Multiple feedbacks containing the same information by one participant were removed, leaving only distinct occurances.
    - **aggregated by low-level taxonomy**: Aggregated mentionings of approaches/data by developers in the survey grouped by low-level taxonomy category.
    - **aggregated by high-level taxonomy**: Aggregated mentionings of approaches/data by developers in the survey grouped by high-level taxonomy category.
- `Q2.1-Q2.7_question_index.csv` - table of IDs given to each participant-question pair for Q2.1-Q2.7 in order to trace back the feeback. 

**RQ3_automated_support/** 
	- content explained in the README.md file located in "RQ3_automated_support/README.md"

## References
[1] Moritz Beller, Alberto Bacchelli, Andy Zaidman, and Elmar Juergens. 2014. Modern code reviews
 in open-source projects: which problems do they fix?. In Proceedings of the 11th 
 Working Conference on Mining Software Repositories (MSR 2014). ACM, New York, NY, USA, 202-211. 
 DOI: http://dx.doi.org/10.1145/2597073.2597082   








    


