PRAGMA foreign_keys=OFF;--> statement-breakpoint
CREATE TABLE `__new_companions` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`species` text DEFAULT 'dog' NOT NULL,
	`breed` text,
	`dob` text,
	`sex` text,
	`weight_unit` text DEFAULT 'kg' NOT NULL,
	`microchip` text,
	`avatar_path` text,
	`avatar_provider` text DEFAULT 'local' NOT NULL,
	`avatar_storage_key` text,
	`bio` text,
	`feeding_schedule` text,
	`walk_schedule` text,
	`medication_schedule` text,
	`emergency_contact_name` text,
	`emergency_contact_phone` text,
	`vet_name` text,
	`vet_phone` text,
	`vet_clinic` text,
	`notes_for_sitter` text,
	`is_active` integer DEFAULT true NOT NULL,
	`archived_at` integer,
	`archive_note` text,
	`created_at` integer DEFAULT (unixepoch()) NOT NULL
);
--> statement-breakpoint
INSERT INTO `__new_companions`("id", "name", "species", "breed", "dob", "sex", "weight_unit", "microchip", "avatar_path", "avatar_provider", "avatar_storage_key", "bio", "feeding_schedule", "walk_schedule", "medication_schedule", "emergency_contact_name", "emergency_contact_phone", "vet_name", "vet_phone", "vet_clinic", "notes_for_sitter", "is_active", "archived_at", "archive_note", "created_at") SELECT "id", "name", "species", "breed", "dob", "sex", "weight_unit", "microchip", "avatar_path", "avatar_provider", "avatar_storage_key", "bio", "feeding_schedule", "walk_schedule", "medication_schedule", "emergency_contact_name", "emergency_contact_phone", "vet_name", "vet_phone", "vet_clinic", "notes_for_sitter", "is_active", "archived_at", "archive_note", "created_at" FROM `companions`;--> statement-breakpoint
DROP TABLE `companions`;--> statement-breakpoint
ALTER TABLE `__new_companions` RENAME TO `companions`;--> statement-breakpoint
PRAGMA foreign_keys=ON;--> statement-breakpoint
CREATE INDEX `companion_active_idx` ON `companions` (`is_active`);--> statement-breakpoint
CREATE TABLE `__new_users` (
	`id` text PRIMARY KEY NOT NULL,
	`username` text NOT NULL,
	`display_name` text NOT NULL,
	`password_hash` text,
	`calendar_feed_token` text,
	`role` text DEFAULT 'member' NOT NULL,
	`is_active` integer DEFAULT true NOT NULL,
	`created_at` integer DEFAULT (unixepoch()) NOT NULL,
	`last_login_at` integer,
	`theme` text DEFAULT 'system' NOT NULL,
	`locale` text DEFAULT 'zh' NOT NULL,
	`email` text,
	`phone` text,
	`oidc_subject` text,
	`oidc_issuer` text,
	`reminder_undo_seconds` integer,
	`default_recurrence_unit` text,
	`notify_reminder_email` integer DEFAULT false NOT NULL,
	`notify_shift_email` integer DEFAULT false NOT NULL,
	`api_access_enabled` integer DEFAULT true NOT NULL,
	`ntfy_topic` text,
	`avatar_path` text,
	`avatar_provider` text,
	`avatar_storage_key` text,
	`totp_secret` text,
	`totp_enabled_at` integer,
	`totp_last_step` integer
);
--> statement-breakpoint
INSERT INTO `__new_users`("id", "username", "display_name", "password_hash", "calendar_feed_token", "role", "is_active", "created_at", "last_login_at", "theme", "locale", "email", "phone", "oidc_subject", "oidc_issuer", "reminder_undo_seconds", "default_recurrence_unit", "notify_reminder_email", "notify_shift_email", "api_access_enabled", "ntfy_topic", "avatar_path", "avatar_provider", "avatar_storage_key", "totp_secret", "totp_enabled_at", "totp_last_step") SELECT "id", "username", "display_name", "password_hash", "calendar_feed_token", "role", "is_active", "created_at", "last_login_at", "theme", "locale", "email", "phone", "oidc_subject", "oidc_issuer", "reminder_undo_seconds", "default_recurrence_unit", "notify_reminder_email", "notify_shift_email", "api_access_enabled", "ntfy_topic", "avatar_path", "avatar_provider", "avatar_storage_key", "totp_secret", "totp_enabled_at", "totp_last_step" FROM `users`;--> statement-breakpoint
DROP TABLE `users`;--> statement-breakpoint
ALTER TABLE `__new_users` RENAME TO `users`;--> statement-breakpoint
CREATE UNIQUE INDEX `users_username_unique` ON `users` (`username`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_oidc_idx` ON `users` (`oidc_issuer`,`oidc_subject`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_email_idx` ON `users` (`email`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_calendar_feed_token_idx` ON `users` (`calendar_feed_token`);