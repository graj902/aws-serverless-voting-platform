import { useState, useEffect } from 'react';
import { useAuth } from '../store/AuthContext';
import { Navigate } from 'react-router-dom';
import { api } from '../services/api';

const OPTIONS = ['Goa', 'Manali', 'Udaipur'];

const Vote = () => {
  const { isAuthenticated } = useAuth();
  const [selectedVote, setSelectedVote] = useState('');
  const [currentVote, setCurrentVote] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [message, setMessage] = useState('');

  const fetchVote = async () => {
    setLoading(true);
    setError('');
    try {
      const response = await api.get('/vote');
      if (response.data && response.data.vote) {
        setCurrentVote(response.data.vote);
        setSelectedVote(response.data.vote);
      }
    } catch (err: any) {
      if (err.response?.status !== 404) {
        setError('Failed to fetch vote');
      }
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (isAuthenticated) {
      fetchVote();
    }
  }, [isAuthenticated]);

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  const handleSubmit = async () => {
    setError('');
    setMessage('');
    try {
      if (currentVote) {
        await api.put('/vote', { destination: selectedVote });
        setMessage('Vote updated successfully!');
      } else {
        await api.post('/vote', { destination: selectedVote });
        setMessage('Vote submitted successfully!');
      }
      fetchVote();
    } catch (err) {
      setError('Failed to save vote');
    }
  };

  const handleDelete = async () => {
    setError('');
    setMessage('');
    try {
      await api.delete('/vote');
      setMessage('Vote deleted successfully!');
      setCurrentVote('');
      setSelectedVote('');
    } catch (err) {
      setError('Failed to delete vote');
    }
  };

  if (loading) return <div>Loading...</div>;

  return (
    <div>
      <h1>Cast Your Vote</h1>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      {message && <p style={{ color: 'green' }}>{message}</p>}
      
      <div>
        {OPTIONS.map((option) => (
          <label key={option}>
            <input
              type="radio"
              value={option}
              checked={selectedVote === option}
              onChange={(e) => setSelectedVote(e.target.value)}
            />
            {option}
          </label>
        ))}
      </div>

      <button onClick={handleSubmit} disabled={!selectedVote || selectedVote === currentVote}>
        {currentVote ? 'Update Vote' : 'Submit Vote'}
      </button>

      {currentVote && (
        <button onClick={handleDelete} style={{ marginLeft: '10px' }}>
          Delete Vote
        </button>
      )}
    </div>
  );
};

export default Vote;
