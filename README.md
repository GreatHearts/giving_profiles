A social network based on donations. 

TODOs:
mobile css 
add share-to-fb buttons

(infrastructure)
homepage
login for admins, logout
user profile page with user details
edit your details
add a donation by amount to existing org
edit details of org (type, website) 
search users
search organizations
search with facets 
add donation to new organization
admin: see all users, donations, organizations

on profile page: set my pinned cause & org + explanation text
view feed: see activity in my network
view organization: see who from my friends donated to this org
User profile Pic
Login with FB
 
Additions for 20.11
- add donation form (only accepts positive amounts, existing orgs)
- edit org page: only for admins (currently erez, me)
- view amounts of donation - only for yourself 
- org page: show donors pics with link back to them 
- user name and address: from profile 
- header changes by layout (+ "home" which is very standard)
- login page by layout
- basic feed
- search results: show total amount raised, plus actual faces 



next steps (prioritized):

- add list of organizations (I have a list of 60, is that enough to start with, plus I will ad Goodwills)
- way to add more orgs manually 
- user profile: view badges (by amount of donations?)
- (adjustments for mobile-friendly)
- user profile: visualization of donations by cause, type 
- delete single donation 
- Share to facebook (a donation or organization)
- delete account
- enable "verifying" a user by admin (blue checkmark)
- view organizations by type 
- make facets reflect search
- embed facebook posts in feed
- ability to add organization 

- my profile
- fix header in safari 



questions: can you give me:
- a list of "causes"
- a list of "types" of organization (e.g. envrionmental, human rights, etc)
- do organizations have both a cause and a type?
- how to recognize somebody's network from facebook? Perhaps just let them choose a network on the site? (this would also allow non-FB people to sign up and also make things easier for me.)
- what are badges given for?

Comments:
Homepage, Org page - Erez will send designs 
2. Feed - show donations, 'announcements' (like earning a badge, or maybe 'expressing interest in a charity') - FB posts 
3. Supply your total yearly income
4. donations - don't show amount 
5. User profile page - featured organizations and causes (not just one) with text. 
6. Charity Badges: a charity gets a badge if it gets rated by givewell's top-rated charities. 
7. User badges: 1. whether total donations reaches some percentage of income, 2. whether a % of donations are to 'highly effective charities' (those with givewell rating). 

.. 

8. Users can only see donations by others in the same group as them?

-- 
Privacy Settings:
- For the profile: 1. completely private (only you can see your profile), 2. only your Facebook friends can see, and 3. completely public.  
- For a given organization: 1. completely private: is never announced and is excluded from your profile, 2. gets included in your profile and on your FB friends' news feeds.
- For individual donations: 1. completely privates never announced and is excluded from your profile, 2. gets included in your profile and on your FB friends' news feeds.

List of charities - the link you sent, as far as I can tell, will not give us a list of charities, but we can find those elsewhere. For example https://en.wikipedia.org/wiki/List_of_charitable_foundations or https://www.forbes.com/top-charities/list/2/#tab:rank. These will give us about 200 organizations, and we can add more. I suggest then to start with one of these lists and allow admins (like you or someone on your behalf) to add more, later on. And in the meantime, users will only be able to choose from the list we create (and if we choose, we can later let them add their own organizations).

$ filewatcher '**/*.scss' 'scss $FILENAME > $FILENAME.css; echo "created"-$FILENAME; date'