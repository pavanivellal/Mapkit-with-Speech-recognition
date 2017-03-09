# Mapkit-with-Speech-recognition
It is an iOS Application that provides directions between two places on a map. The application chooses to show direction between 2 places mentioned or from current location to destination based on the speech input of the user. The application is designed to recognize the user's intention from the speech and provides directions accordingly. I have made use of MapKit and Speech recognition in this application. All of the users searches are stored in a flat file for enhancing speech recognition. 


### 1.	App permission
Provide the following permissions to let the app access your voice input.

### 2.	Speech to Text Screen
Select the mic button and say what you would like to see in the map in the following format.
#### Template 1: Find directions from [source location] to [destination location]
#### Template 2: Find directions between [source location] to [destination location]
#### Template 3: Find route between [source location] to [destination location]
The above 3 template text is parsed where the program looks for the keywords from and to and finds the words between them to show in the map. 
#### Template 4: Let’s go to [destination location]
#### Template 5: go to [destination location]
#### Template 6: goto [destination location]
#### Template 7: route to [destination location]
The above 3 template text is parsed where the program looks for the keyword to and finds the text following it and takes the current location as source location.

### 3.	Find direction
Say ***“Find directions from Fremont California to San Jose California”***. The location information is displayed in a mapview.
     
### 4.	Find route
Say ***“Find route from LA California to San Jose California” ***
    
### 5.	Let’s Go
Say ***“Let’s go to San Jose State University”***. In this case the user’s current location is picked and used as the source location. This requires the user to grant the app permission to access the user’s current location.

Say ***“Let’s go to LA California” ***

### 6.	Searches stored in Flat File
All the searches are stored in a flat file for future references
 




