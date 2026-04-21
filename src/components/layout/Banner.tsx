"use client";
import { motion } from "framer-motion";
import clsx from "clsx";
import { useI18n } from "@/components/i18n/I18nProvider";

interface BannerProps {
  title: string;
  subtitle?: string;
  gradientFrom?: string;
  gradientTo?: string;
  children?: React.ReactNode;
  overlay?: boolean;
}

const Banner: React.FC<BannerProps> = ({ title, subtitle, gradientFrom, gradientTo, children, overlay }) => {
  const { t } = useI18n();

  return (
    <motion.section initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} className={clsx("relative rounded-2xl p-6 md:p-10 overflow-hidden shadow-lg border border-white/20 dark:border-white/5", "bg-gradient-to-br", gradientFrom || "from-[var(--gradient-from)]", gradientTo || "to-[var(--gradient-to)]", "text-slate-900 dark:text-slate-100")}>      {overlay && <div className="absolute inset-0 backdrop-blur-lg bg-white/30 dark:bg-slate-900/30" />}
      <div className="relative z-10">
        <h1 className="text-2xl md:text-3xl font-bold tracking-tight drop-shadow-sm">{title || t('banner.welcome')}</h1>
        {subtitle && <p className="mt-2 max-w-2xl text-sm md:text-base text-slate-700/80 dark:text-slate-200/80">{subtitle || t('banner.subtitle')}</p>}
        {children && <div className="mt-4">{children}</div>}
      </div>
      <div className="absolute -top-24 -right-24 w-72 h-72 bg-[var(--color-primary)]/20 rounded-full blur-3xl" />
      <div className="absolute -bottom-24 -left-24 w-72 h-72 bg-[var(--color-primary)]/10 rounded-full blur-3xl" />
    </motion.section>
  );
};

export default Banner;
