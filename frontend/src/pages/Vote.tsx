import { useAuth } from '../store/AuthContext';
import { Navigate } from 'react-router-dom';

const Vote = () => {
  const { isAuthenticated } = useAuth();

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  return (
    <div>
      <h1>Vote</h1>
      <p>Voting form placeholder (Protected).</p>
    </div>
  );
};

export default Vote;
