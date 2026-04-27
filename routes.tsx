import { Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Register from './pages/Register';
import Dashboard from './pages/Dashboard';
import Opportunities from './pages/Opportunities';
import CodingPractice from './pages/CodingPractice';
import SchedulePage from './pages/Schedule';
import Performance from './pages/Performance';
import Emails from './pages/Emails';
import Profile from './pages/Profile';
import type { ReactNode } from 'react';

interface RouteConfig {
  name: string;
  path: string;
  element: ReactNode;
  visible?: boolean;
  requiresAuth?: boolean;
}

const routes: RouteConfig[] = [
  {
    name: 'Login',
    path: '/login',
    element: <Login />,
    requiresAuth: false,
  },
  {
    name: 'Register',
    path: '/register',
    element: <Register />,
    requiresAuth: false,
  },
  {
    name: 'Dashboard',
    path: '/dashboard',
    element: <Dashboard />,
    requiresAuth: true,
  },
  {
    name: 'Opportunities',
    path: '/opportunities',
    element: <Opportunities />,
    requiresAuth: true,
  },
  {
    name: 'Coding Practice',
    path: '/coding-practice',
    element: <CodingPractice />,
    requiresAuth: true,
  },
  {
    name: 'Schedule',
    path: '/schedule',
    element: <SchedulePage />,
    requiresAuth: true,
  },
  {
    name: 'Performance',
    path: '/performance',
    element: <Performance />,
    requiresAuth: true,
  },
  {
    name: 'Emails',
    path: '/emails',
    element: <Emails />,
    requiresAuth: true,
  },
  {
    name: 'Profile',
    path: '/profile',
    element: <Profile />,
    requiresAuth: true,
  },
  {
    name: 'Root',
    path: '/',
    element: <Navigate to="/dashboard" replace />,
    requiresAuth: true,
  },
];

export default routes;
