Grouped
=======

A Group Study App

Prototype URL: http://invis.io/CT1JVSTQ6

Features: 

 - Helps students find other students to study with by allowing students to post when, where and what they are studying.
 
Implementation:
 
 - Apple Maps API: https://developer.apple.com/maps/
 - Parse: https://www.parse.com/
 - Tethr: http://www.invisionapp.com/tethr

-------------------------
Latest Commit:

(Kevin Zeng) Progress: Most Network & GUI Finished
-Working so far alone has demotivated me for this whole week. I'm not gonna work anymore until Thrusday or Friday, since most of it has been done.
-Anyway, storyboard has roughly all the views except NewPostController.
-Views I've worked on from previous commit: All: View(login), SignUp, Find[group], CreateGroup, JoinGroup, Feed, Profile, NewPost
-Did all GUI and view constraints. Everything makes good fit. Hate the navi-bar, though; the fixed font size makes it feel too big.
-Tested and running on the iOS simulator. Of course, constraints are there, so the iPad simulator should work as well.

Bugs:
-XCode Issue: xcode occasionally swaps the navigation bar with the  bottom toolbar, as in it just appears on the bottom rather than on top. This doesn't affect the simulated GUI.
-Network location (geopoint) breaks occasionally: it gets nil from the LocationManager that locates the user, which then returns the zero/zero coordinates in the geopoint.
  It also randomly moves from the origin location, even from a completely stagnant laptop; this seems like a definite fault in the GPS accuracy system.
-User info doesn't carry over screens sometimes; this only happened once when I tried to create a group. The group will say no one for the host user.
-(Temporary Fixed) Logging out/Leave Group from the Profile page makes the navigation controller have a <BackToView button, allowing the user to return.
This was fixed by putting a button over it. For the login page, there is an invisible button overwriting the default navi. The find group page has the logout button in place.

The Need-to-dos:
-The 'Post' table needs to be finished. I'm not sure what this is, but it has been here since I started from weeks ago.
-Ergo, the 'NewPost' controller needs completion along side the 'Post' table. Example code is everywhere.
-Look up solutions for network location fix.
-Logo for launch screen and login screen (to pretty up)
-Change the copyright info in the launch screen. It's been (C)Jonathan's for awhile.

The Can-to-dos:
-Profile pictures: This will require searching the directory of the device (hard part). And putting files into parse (easy part).
-Group End/Termination: We need the conditions for when this might occur (example: when the host user leaves the group, when everyone leaves the group, or after the end time).
-End time for Group: In the create group view, we could implement the End Time field (re-constraint everything in the GUI afterwards).
  This info would also be displayed in the Join Group view as the description could say, Time Left.
-Color coding: If you remember, this was Jonathan's suggestion. The background for groups are color code based on their distance/time.
  Obviously this requires the distance from Geopoints figured out.
-Incrementing the start time for delayed groups: This hasn't been implemented, but the segmented control suggests a "Later" option and a text field next to it.
  Incrementing time requires a different GUI keyboard or another view entirely (for space and for incrementing minutes, hours, etc.). There isn't much space for the text field to be adjacent to it.
-Changing the spacing in the cells of the Find Group: it's pretty crammed and pretty ugly for 3 elements in one row (like the navigation bar). This requires re-constrainting the cell.
