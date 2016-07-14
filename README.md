# Anonymokata

## Github anonymizer, allowing for kata reviews without concern of author

This script will allow any github repository to be cloned, scrubbed (removing all references to 
username and email), creating new repository within organization account and pushing the 'cleaned'
code to new repository.

1. clone this repository - [anonymokata](https://github.com/ddaugher/anonymokata)
2. change directory, to the directory where you want to clone the candidate repository.
3. execute the anonymizer script...

	```
		[anonymokata]/anon.sh
	```

4. answer the questions.

	```
		Enter the name of the organization. [name of your organization] : 
		Enter the name of the user within anonymokata. [authorized github user]
		Enter the name of the user within anonymokata. [authorized github user] :
		Enter the name of the new repository. [this will be generated] :
		Enter the GitHub URL to clone : [paste the candidate URL here]
		Do you really want to anonymize this repo? [Y/n]: 
	```
5. you are done.


---

