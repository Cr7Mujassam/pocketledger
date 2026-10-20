-- PocketLedger cloud database setup
-- Run this entire script in Supabase Dashboard > SQL Editor.
-- Row Level Security ensures each signed-in user can only access their own records.
create extension if not exists pgcrypto;

create table if not exists public.transactions (
  id uuid primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null,
  type text not null check (type in ('income','expense')),
  amount numeric(14,2) not null check (amount > 0),
  category text not null,
  note text not null default '',
  payment text not null default 'UPI',
  created_at timestamptz not null default now()
);
create index if not exists transactions_user_date_idx on public.transactions(user_id, date desc);

create table if not exists public.budgets (
  user_id uuid not null references auth.users(id) on delete cascade,
  category text not null,
  amount numeric(14,2) not null check (amount > 0),
  created_at timestamptz not null default now(),
  primary key (user_id, category)
);

alter table public.transactions enable row level security;
alter table public.budgets enable row level security;

drop policy if exists "Users manage own transactions" on public.transactions;
create policy "Users manage own transactions" on public.transactions
for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "Users manage own budgets" on public.budgets;
create policy "Users manage own budgets" on public.budgets
for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

grant select, insert, update, delete on public.transactions to authenticated;
grant select, insert, update, delete on public.budgets to authenticated;
