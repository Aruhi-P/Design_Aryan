# FitNotebook — browser-ready website

This version adapts the seven-screen notebook UI shared in the chat into plain HTML/CSS/JS, retaining the working Supabase state-management implementation. No React, Node, Python or local build required.

## Files
- `index.html`: website entry point and navigation
- `style.css`: notebook visual styling
- `app.js`: interactive screens, activity generation and cloud saves
- `config.js`: browser-safe Supabase project URL and publishable key
- `setup.sql`: create progress table and enable Row Level Security in Supabase SQL editor (run once only)

## Run locally
Open `index.html` in Chrome. Internet access is required for the Supabase SDK and cloud sync. If the browser blocks Supabase authentication under `file://`, the deployed Netlify HTTPS URL should be used for cloud verification. The website also keeps a local browser backup.

## Deploy using GitHub and Netlify (no paid domain)
1. Verify `setup.sql` has been run in your Supabase SQL Editor and **Authentication > Sign In / Providers > Anonymous sign-ins** is enabled.
2. Create a GitHub repository. Use **Add file > Upload files** and upload the individual files in this folder (not the ZIP as one file). Commit them to the main branch.
3. In Netlify choose **Add new project > Import an existing project > GitHub**. Authorize Netlify and choose that repository.
4. Set **Base directory** blank, **Build command** blank, and **Publish directory** `.` (repository root). Deploy.
5. Open your generated `*.netlify.app` address. No custom domain purchase is necessary.
6. Try creating a plan, checking a habit, reloading, and confirming a row exists in Supabase Table Editor > fitness_progress. Database connection is not verified until you test it in your account.

**Security**: `config.js` contains only a browser-safe publishable key; never add `service_role` or `sb_secret_...` credentials. RLS is required to keep users' records isolated. For a public launch, review anonymous sign-in abuse protection.

**Criterion C**: Keep an accurate record of actual changes, screenshots and tests. The initial UI was AI-assisted; record later changes and bug fixes as they occur.

## Fix: synchronized activity and progress screens
- Marking or undoing a workout updates the shared saved state and refreshes the current activity display. Visit **Progress & Goals** to see the real 12-week chart, milestones, and recent activity.
- Checking a habit in either **Dashboard** or **Habit Tracker** refreshes the visible counts. **Progress & Goals** now includes a current-week habit summary for all four habits.
- Progress is saved locally first and sent to Supabase when configured; check the footer for cloud-save status.
- For reliable checking: complete a workout, open Progress & Goals, check total/milestone, then tick a habit and check its weekly count. Refresh and repeat.
- This is a bug-fix development stage for Criterion C; screenshots should show the observed app behavior after actual testing.


## Changes in this update
- Setup becomes a read-only summary after initial plan creation; later edits happen only in Adjust Plan.
- Adjust Plan choices are drafts until **Save Changes** is pressed.
- Progress chart and 12-week plan count saved completions using their recorded week rather than assuming the original days are still selected.
- Progress chart displays numerical session counts above each week.
- Every screen uses readable DM Sans instead of handwritten fonts.
- Supabase configuration and database schema are unchanged.

### Check the improvements
1. Complete one activity, open Progress & Goals: Week 1 (or the current plan week) should increase by one.
2. Undo it and check the count decreases.
3. Set a different day in Adjust Plan, press Save Changes, and confirm recorded history remains visible.
4. Return to Start / Setup; it should display a summary, not editable initial setup controls.
5. Refresh to confirm the changes remain saved.
