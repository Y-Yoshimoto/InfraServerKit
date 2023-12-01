import { useRoutes } from 'react-router-dom';

// routes
import MainRoutes from './main';

export default function ThemeRoutes() {
    return useRoutes([MainRoutes, AuthenticationRoutes]);
}