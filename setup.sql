-- Run once in Supabase Dashboard > SQL Editor.
-- Each signed-in (including anonymous) user can read/write only their own progress.
create table if not exists public.fitness_progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.fitness_progress enable row level security;
revoke all on public.fitness_progress from anon;
grant select, insert, update, delete on public.fitness_progress to authenticated;

drop policy if exists "Read own fitness progress" on public.fitness_progress;
create policy "Read own fitness progress" on public.fitness_progress
for select to authenticated using ((select auth.uid()) = user_id);

drop policy if exists "Create own fitness progress" on public.fitness_progress;
create policy "Create own fitness progress" on public.fitness_progress
for insert to authenticated with check ((select auth.uid()) = user_id);

drop policy if exists "Update own fitness progress" on public.fitness_progress;
create policy "Update own fitness progress" on public.fitness_progress
for update to authenticated using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Delete own fitness progress" on public.fitness_progress;
create policy "Delete own fitness progress" on public.fitness_progress
for delete to authenticated using ((select auth.uid()) = user_id);
