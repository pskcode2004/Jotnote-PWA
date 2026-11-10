-- Run once in Supabase SQL Editor AFTER migration-005.sql.
-- Lock down which columns a signed-in user may change (RLS only limits rows, not columns).

-- An editor could previously UPDATE notes.owner_id and take the note over from its owner.
-- The app only ever updates the title (blocks_touch bumps updated_at as security definer).
revoke update on public.notes from authenticated;
grant update (title) on public.notes to authenticated;

-- A user could previously change profiles.email, which is the key used to share notes
-- and is unique, so squatting someone's address would break their later sign-up.
-- The app only ever updates display_name.
revoke update on public.profiles from authenticated;
grant update (display_name) on public.profiles to authenticated;
