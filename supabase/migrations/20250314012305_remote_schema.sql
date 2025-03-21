create table "public"."alarms" (
    "id" bigint generated by default as identity not null,
    "time" time without time zone,
    "user_id" uuid,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."alarms" enable row level security;

create table "public"."doses" (
    "id" bigint generated by default as identity not null,
    "dose" integer,
    "user_id" uuid not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."doses" enable row level security;

create table "public"."goals" (
    "id" bigint generated by default as identity not null,
    "goal" integer,
    "user_id" uuid not null,
    "created_at" date not null default now(),
    "updated_at" date
);


alter table "public"."goals" enable row level security;

create table "public"."profiles" (
    "id" uuid not null,
    "updated_at" timestamp with time zone,
    "username" text,
    "avatar_url" text
);


alter table "public"."profiles" enable row level security;

CREATE UNIQUE INDEX alarms_pkey ON public.alarms USING btree (id);

CREATE UNIQUE INDEX doses_pkey ON public.doses USING btree (id);

CREATE UNIQUE INDEX goals_pkey ON public.goals USING btree (id);

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX profiles_username_key ON public.profiles USING btree (username);

alter table "public"."alarms" add constraint "alarms_pkey" PRIMARY KEY using index "alarms_pkey";

alter table "public"."doses" add constraint "doses_pkey" PRIMARY KEY using index "doses_pkey";

alter table "public"."goals" add constraint "goals_pkey" PRIMARY KEY using index "goals_pkey";

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."alarms" add constraint "alarms_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."alarms" validate constraint "alarms_user_id_fkey";

alter table "public"."doses" add constraint "doses_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."doses" validate constraint "doses_user_id_fkey";

alter table "public"."goals" add constraint "goals_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."goals" validate constraint "goals_user_id_fkey";

alter table "public"."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_id_fkey";

alter table "public"."profiles" add constraint "profiles_username_key" UNIQUE using index "profiles_username_key";

alter table "public"."profiles" add constraint "username_length" CHECK ((char_length(username) >= 3)) not valid;

alter table "public"."profiles" validate constraint "username_length";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
begin
  insert into public.profiles (id, full_name, avatar_url)
  values (new.id, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'avatar_url');
  return new;
end;
$function$
;

grant delete on table "public"."alarms" to "anon";

grant insert on table "public"."alarms" to "anon";

grant references on table "public"."alarms" to "anon";

grant select on table "public"."alarms" to "anon";

grant trigger on table "public"."alarms" to "anon";

grant truncate on table "public"."alarms" to "anon";

grant update on table "public"."alarms" to "anon";

grant delete on table "public"."alarms" to "authenticated";

grant insert on table "public"."alarms" to "authenticated";

grant references on table "public"."alarms" to "authenticated";

grant select on table "public"."alarms" to "authenticated";

grant trigger on table "public"."alarms" to "authenticated";

grant truncate on table "public"."alarms" to "authenticated";

grant update on table "public"."alarms" to "authenticated";

grant delete on table "public"."alarms" to "service_role";

grant insert on table "public"."alarms" to "service_role";

grant references on table "public"."alarms" to "service_role";

grant select on table "public"."alarms" to "service_role";

grant trigger on table "public"."alarms" to "service_role";

grant truncate on table "public"."alarms" to "service_role";

grant update on table "public"."alarms" to "service_role";

grant delete on table "public"."doses" to "anon";

grant insert on table "public"."doses" to "anon";

grant references on table "public"."doses" to "anon";

grant select on table "public"."doses" to "anon";

grant trigger on table "public"."doses" to "anon";

grant truncate on table "public"."doses" to "anon";

grant update on table "public"."doses" to "anon";

grant delete on table "public"."doses" to "authenticated";

grant insert on table "public"."doses" to "authenticated";

grant references on table "public"."doses" to "authenticated";

grant select on table "public"."doses" to "authenticated";

grant trigger on table "public"."doses" to "authenticated";

grant truncate on table "public"."doses" to "authenticated";

grant update on table "public"."doses" to "authenticated";

grant delete on table "public"."doses" to "service_role";

grant insert on table "public"."doses" to "service_role";

grant references on table "public"."doses" to "service_role";

grant select on table "public"."doses" to "service_role";

grant trigger on table "public"."doses" to "service_role";

grant truncate on table "public"."doses" to "service_role";

grant update on table "public"."doses" to "service_role";

grant delete on table "public"."goals" to "anon";

grant insert on table "public"."goals" to "anon";

grant references on table "public"."goals" to "anon";

grant select on table "public"."goals" to "anon";

grant trigger on table "public"."goals" to "anon";

grant truncate on table "public"."goals" to "anon";

grant update on table "public"."goals" to "anon";

grant delete on table "public"."goals" to "authenticated";

grant insert on table "public"."goals" to "authenticated";

grant references on table "public"."goals" to "authenticated";

grant select on table "public"."goals" to "authenticated";

grant trigger on table "public"."goals" to "authenticated";

grant truncate on table "public"."goals" to "authenticated";

grant update on table "public"."goals" to "authenticated";

grant delete on table "public"."goals" to "service_role";

grant insert on table "public"."goals" to "service_role";

grant references on table "public"."goals" to "service_role";

grant select on table "public"."goals" to "service_role";

grant trigger on table "public"."goals" to "service_role";

grant truncate on table "public"."goals" to "service_role";

grant update on table "public"."goals" to "service_role";

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";

create policy "Public profiles are viewable by everyone."
on "public"."profiles"
as permissive
for select
to public
using (true);


create policy "Users can insert their own profile."
on "public"."profiles"
as permissive
for insert
to public
with check ((( SELECT auth.uid() AS uid) = id));


create policy "Users can update own profile."
on "public"."profiles"
as permissive
for update
to public
using ((( SELECT auth.uid() AS uid) = id));



