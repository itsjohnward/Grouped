Grouped
=======

A Group Study App
Prototype URL: http://invis.io/CT1JVSTQ6

Features: 
 - Helps students find other students to study with by allowing students to post when, where and what they are studying.
 
Implementation:
 - Parse: https://www.parse.com/

Latest Commit:

======================= Progress: Dazzingly Unfinished Product ====================================

When a group decides to work together physically, they'd have to rely on another product instead of ours.
After installing our product, the user starts off by registering. This way we'll know he/she is a real user because they're providing us with their email and school affliation.
Our product shows groups someone had created; providing the geolocation of the user when he/she created it and fields the host user would fill out randomly, like the group name, description of the group, and the subject the group will focus on.
When a user joins a group, he/she is moved to a screen with no info and a button linking to an empty page. He/she can choose to leave the group, or just logout.

======================= Progress: Things that hadn't changed from last week========================
 - Storyboard has roughly all the views except NewPostController.
 - Tested and running on the iOS simulator. Of course, constraints are there, so the iPad simulator should work as well.

=== Bugs: ========================
 - Network location (geopoint) breaks occasionally: it gets nil from the LocationManager that locates the user, which then returns the zero/zero coordinates in the geopoint.
  - It also randomly moves from the origin location, even from a completely stagnant laptop; this seems like a definite fault in the GPS accuracy system.

=== The Need-to-dos: ========================
 - The 'Post' table needs to be finished. I'm not sure what this is, but it has been here since I started from weeks ago.
 - Ergo, the 'NewPost' controller needs completion along side the 'Post' table. Example code is everywhere.
 - Look up solutions for network location fix.
 - Logo for launch screen and login screen (to pretty up)
 - Change the copyright info in the launch screen. It's been (C)Jonathan's for awhile.

=== The Can-to-dos: ========================
 - Profile pictures: This will require searching the directory of the device. And putting files into parse to share.
 - Group End/Termination: We need the conditions for when this might occur (example: when the host user leaves the group, when everyone leaves the group, or after the end time).
 - End time for Group: In the create group view, we could implement the End Time field.
  This info would also be displayed in the Join Group view as the description could say, Time Left.
 - Color coding: If you remember, this was Jonathan's suggestion. The background for groups are color code based on their distance/time. Changes from last week: the white background changed to blue.
 - Incrementing the start time for delayed groups: This hasn't been implemented, but the segmented control suggests a "Later" option and a text field next to it.
