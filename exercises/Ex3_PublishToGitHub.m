%[text] # Exercise 3: 
%[text] 
%% Exercise 3: Publishing Your Climate Engineering Work to GitHub
% *Share Your Impact, Inspire Others*
%
% In this exercise, you'll publish your complete Climate Action Workshop project
% to GitHub, making your work accessible to the world and contributing to the
% global conversation on climate solutions.
%
% <<../images/github_banner.png>>

%% 📖 Why Publish to GitHub?
% 
% Publishing your climate engineering work to GitHub allows you to:
% 
% * *Share* your carbon footprint analysis tools with others
% * *Inspire* people to take climate action based on data
% * *Showcase* your MATLAB and engineering skills
% * *Contribute* to open-source climate solutions
% * *Document* your learning journey at MATLAB EXPO 2025
% 
% GitHub serves as your professional portfolio and enables collaboration on
% climate solutions at scale.

%% 🎯 What You'll Accomplish
%
% By the end of this exercise, you will have:
% 
% 1. ✅ Created a new GitHub repository
% 2. ✅ Initialized Git in your project directory
% 3. ✅ Committed all your workshop files
% 4. ✅ Pushed your complete project to GitHub
% 5. ✅ Created a professional README showcasing your work
% 6. ✅ Made your climate engineering tools publicly accessible
%
% *Duration*: 15 minutes (10 min work, 5 min teach/review)

%% 🚀 Part 1: MATLAB Online Git Integration
% *MATLAB Online R2025a now has built-in GitHub integration!*
%
% MATLAB Online provides seamless integration with GitHub, making it easy to
% version control your work without leaving the MATLAB environment.

%% Step 1: Verify Git Availability

% Check if Git is available in MATLAB Online
[status, cmdout] = system('git --version');

if status == 0
    fprintf('✓ Git is available!\n');
    fprintf('  Version: %s\n', cmdout);
else
    fprintf('✗ Git not found. Contact workshop facilitator.\n');
    return;
end

%% Step 2: Configure Git (First Time Only)
% Set your Git identity - this will appear in your commit history

% TODO: Replace these with YOUR information
gitUserName = 'Your Name';           % e.g., 'Jane Smith'
gitUserEmail = 'your.email@example.com';  % e.g., 'jane.smith@email.com'

% Configure Git
system(['git config --global user.name "' gitUserName '"']);
system(['git config --global user.email "' gitUserEmail '"']);

fprintf('\n✓ Git configured with:\n');
fprintf('  Name:  %s\n', gitUserName);
fprintf('  Email: %s\n', gitUserEmail);

%% 📋 Part 2: Create Your GitHub Repository
% *Do this BEFORE running the next sections*
%
% *Instructions:*
% 
% 1. Open a web browser and go to https://github.com
% 2. Click the *"+"* button (top right) → *"New repository"*
% 3. *Repository name:* |climate-action-workshop|
% 4. *Description:* |Carbon footprint calculator and action tracker built at MATLAB EXPO 2025|
% 5. *Visibility:* Choose *Public* (to share with the world!) or *Private*
% 6. *✗ DO NOT* check "Initialize with README" (we'll create our own)
% 7. Click *"Create repository"*
% 8. *COPY* the repository URL (should look like: |https://github.com/USERNAME/climate-action-workshop.git|)
%
% ⚠ *PAUSE HERE* - Make sure you've completed the steps above before continuing!

%% Step 3: Enter Your GitHub Repository URL

% TODO: Paste your repository URL here
githubRepoURL = 'https://github.com/YOUR-USERNAME/climate-action-workshop.git';

fprintf('\n✓ Repository URL set to:\n  %s\n', githubRepoURL);
fprintf('\n⚠ Make sure this URL is correct before proceeding!\n');

%% 🔧 Part 3: Initialize Your Local Git Repository
% *Convert your project folder into a Git repository*

%% Step 4: Navigate to Project Root

% Get to the project root directory
cd(fileparts(fileparts(mfilename('fullpath'))));
projectRoot = pwd;

fprintf('\n✓ Project root directory:\n  %s\n', projectRoot);

%% Step 5: Initialize Git Repository

[status, cmdout] = system('git init');

if status == 0
    fprintf('\n✓ Git repository initialized!\n');
    fprintf('  %s\n', cmdout);
else
    fprintf('\n✗ Git initialization failed:\n  %s\n', cmdout);
    return;
end

%% Step 6: Create .gitignore File
% Exclude unnecessary files from version control

gitignoreContent = [...
    '# MATLAB\n' ...
    '*.asv\n' ...
    '*.autosave\n' ...
    '*~\n' ...
    '\n' ...
    '# Mac\n' ...
    '.DS_Store\n' ...
    '\n' ...
    '# Windows\n' ...
    'Thumbs.db\n' ...
    '\n' ...
    '# Temporary files\n' ...
    'temp/\n' ...
    'tmp/\n' ...
];

fid = fopen('.gitignore', 'w');
fprintf(fid, gitignoreContent);
fclose(fid);

fprintf('\n✓ .gitignore file created\n');

%% 📝 Part 4: Stage and Commit Your Files
% *Prepare your files for GitHub*

%% Step 7: Stage All Files

[status, cmdout] = system('git add .');

if status == 0
    fprintf('\n✓ All files staged for commit\n');
else
    fprintf('\n✗ Git add failed:\n  %s\n', cmdout);
    return;
end

%% Step 8: Check What Will Be Committed

[~, cmdout] = system('git status');
fprintf('\n📋 Files to be committed:\n');
fprintf('%s\n', cmdout);

%% Step 9: Create Your First Commit

commitMessage = 'Initial commit: Climate Action Workshop - MATLAB EXPO 2025';

[status, cmdout] = system(['git commit -m "' commitMessage '"']);

if status == 0
    fprintf('\n✓ Initial commit created!\n');
    fprintf('  %s\n', cmdout);
else
    fprintf('\n✗ Git commit failed:\n  %s\n', cmdout);
    return;
end

%% 🌐 Part 5: Push to GitHub
% *Upload your work to the cloud*

%% Step 10: Add Remote Repository

[status, cmdout] = system(['git remote add origin ' githubRepoURL]);

if status == 0 || contains(cmdout, 'already exists')
    fprintf('\n✓ Remote repository configured\n');
else
    fprintf('\n✗ Failed to add remote:\n  %s\n', cmdout);
    return;
end

%% Step 11: Rename Branch to 'main' (if needed)

[~, currentBranch] = system('git branch --show-current');
currentBranch = strtrim(currentBranch);

if ~strcmp(currentBranch, 'main')
    system('git branch -M main');
    fprintf('\n✓ Branch renamed to "main"\n');
end

%% Step 12: Push to GitHub

fprintf('\n🚀 Pushing to GitHub...\n');
fprintf('   This may take a moment and might prompt for authentication.\n\n');

[status, cmdout] = system('git push -u origin main');

if status == 0
    fprintf('\n✓ Successfully pushed to GitHub!\n');
    fprintf('  %s\n', cmdout);
    fprintf('\n🎉 Your project is now live on GitHub!\n');
else
    fprintf('\n⚠ Push encountered an issue:\n  %s\n', cmdout);
    fprintf('\n💡 If you see an authentication error:\n');
    fprintf('   1. Go to GitHub.com → Settings → Developer settings\n');
    fprintf('   2. Generate a Personal Access Token (classic)\n');
    fprintf('   3. Use the token as your password when prompted\n');
end

%% 📊 Part 6: View Your Published Repository
% *See your work live on GitHub*

%% Step 13: Open Your GitHub Repository

repoWebURL = strrep(githubRepoURL, '.git', '');
fprintf('\n✓ Your repository is available at:\n');
fprintf('  %s\n', repoWebURL);

% Try to open in browser
try
    web(repoWebURL, '-browser');
    fprintf('\n✓ Opening repository in browser...\n');
catch
    fprintf('\n💡 Copy the URL above to view your repository\n');
end

%% 🎓 Part 7: Understanding Your GitHub Repository
% *What you've accomplished*

fprintf('\n╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                  YOUR GITHUB REPOSITORY                        ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Your repository now contains:\n\n');
fprintf('  📁 data/\n');
fprintf('     - Regional carbon intensity data\n');
fprintf('     - Transport emission factors\n');
fprintf('     - Action library with 50+ climate actions\n\n');
fprintf('  📁 exercises/\n');
fprintf('     - Ex1: Transport emissions calculator\n');
fprintf('     - Ex2: Personal carbon footprint tracker\n');
fprintf('     - Ex3: GitHub publishing (this file!)\n');
fprintf('     - Ex4: Interactive action planning app\n\n');
fprintf('  📁 functions/\n');
fprintf('     - calculateTransportEmissions.m\n');
fprintf('     - calculateHomeEmissions.m\n');
fprintf('     - calculateFoodEmissions.m\n');
fprintf('     - getAvailableActions.m\n');
fprintf('     - calculateActionImpact.m\n');
fprintf('     - and more...\n\n');
fprintf('  📄 README.md\n');
fprintf('     - Professional project documentation\n');
fprintf('     - Workshop acknowledgments\n');
fprintf('     - Usage instructions\n\n');

%% 🔄 Part 8: Making Updates (For Future Changes)
% *How to update your repository after making changes*

fprintf('╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║              UPDATING YOUR REPOSITORY LATER                    ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

fprintf('When you make changes to your code, update GitHub with:\n\n');
fprintf('  >> system(''git add .'');\n');
fprintf('  >> system(''git commit -m "Description of changes"'');\n');
fprintf('  >> system(''git push'');\n\n');

fprintf('Example workflow:\n');
fprintf('  1. Improve your carbon calculator\n');
fprintf('  2. git add .     (stage changes)\n');
fprintf('  3. git commit    (save changes locally)\n');
fprintf('  4. git push      (upload to GitHub)\n\n');

%% 📢 Part 9: Share Your Work
% *Let the world know about your climate engineering project*

fprintf('╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                    SHARE YOUR IMPACT                           ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Ways to share your project:\n\n');
fprintf('  🐦 Twitter/X:\n');
fprintf('      "Just built a carbon footprint calculator at #MATLABEXPO!\n');
fprintf('       Calculate your impact and find reduction actions 🌍\n');
fprintf('       %s #ClimateAction #Engineering"\n\n', repoWebURL);

fprintf('  💼 LinkedIn:\n');
fprintf('      "Excited to share my Climate Action Workshop project\n');
fprintf('       from MATLAB EXPO 2025! Built interactive tools for\n');
fprintf('       carbon footprint analysis and action planning.\n');
fprintf('       Check it out: %s"\n\n', repoWebURL);

fprintf('  📧 Email colleagues:\n');
fprintf('      Subject: Climate Engineering Tools from MATLAB EXPO\n');
fprintf('      Link: %s\n\n', repoWebURL);

%% 🏆 Part 10: Next Steps and Advanced Features
% *Take your project further*

fprintf('╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                        NEXT STEPS                              ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Enhance your repository:\n\n');
fprintf('  ✓ Add screenshots to README\n');
fprintf('  ✓ Create GitHub Pages for live demo\n');
fprintf('  ✓ Add Issues for feature requests\n');
fprintf('  ✓ Enable Discussions for community engagement\n');
fprintf('  ✓ Add license (MIT recommended for open source)\n');
fprintf('  ✓ Create releases for versions\n');
fprintf('  ✓ Add GitHub Actions for automated testing\n\n');

fprintf('Advanced Git features:\n');
fprintf('  • Branching: Create feature branches for experiments\n');
fprintf('  • Pull Requests: Collaborate with others\n');
fprintf('  • Fork: Let others contribute improvements\n');
fprintf('  • Star: Get recognition from the community\n\n');

%% 🎯 Key Takeaways from Exercise 3

fprintf('╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                       KEY TAKEAWAYS                            ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

fprintf('✓ You initialized a Git repository in MATLAB Online\n');
fprintf('✓ You configured Git with your identity\n');
fprintf('✓ You created your first commit\n');
fprintf('✓ You pushed your complete project to GitHub\n');
fprintf('✓ You learned how to update your repository\n');
fprintf('✓ Your climate engineering work is now publicly accessible\n');
fprintf('✓ You''re ready to share your impact with the world\n\n');

fprintf('Remember: Every climate action starts with awareness.\n');
fprintf('By sharing your tools, you''re helping others measure\n');
fprintf('and reduce their carbon footprint. That''s engineering\n');
fprintf('for a better world! 🌍\n\n');

fprintf('════════════════════════════════════════════════════════════════\n');

%% 🔗 Quick Reference Commands

fprintf('\n📝 QUICK REFERENCE: Common Git Commands\n');
fprintf('════════════════════════════════════════════════════════════════\n\n');

fprintf('Check status:           git status\n');
fprintf('Stage all changes:      git add .\n');
fprintf('Commit changes:         git commit -m "message"\n');
fprintf('Push to GitHub:         git push\n');
fprintf('Pull from GitHub:       git pull\n');
fprintf('View commit history:    git log --oneline\n');
fprintf('Create new branch:      git checkout -b branch-name\n');
fprintf('Switch branches:        git checkout branch-name\n\n');

fprintf('════════════════════════════════════════════════════════════════\n');

%% 👏 Congratulations!

fprintf('\n\n');
fprintf('╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                      🎉 CONGRATULATIONS! 🎉                    ║\n');
fprintf('╠════════════════════════════════════════════════════════════════╣\n');
fprintf('║                                                                ║\n');
fprintf('║  You''ve successfully published your Climate Action Workshop   ║\n');
fprintf('║  project to GitHub! Your work is now part of the global       ║\n');
fprintf('║  movement toward data-driven climate solutions.               ║\n');
fprintf('║                                                                ║\n');
fprintf('║  🌍 Making an impact, one line of code at a time.             ║\n');
fprintf('║                                                                ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Continue to: <a href="matlab:open(''Ex4_CarbonActionTracker.m'')">Exercise 4 → Interactive Action Tracker</a>\n\n');
%[text] 

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
