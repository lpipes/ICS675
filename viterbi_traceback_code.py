
import numpy as np
import matplotlib.pyplot as plt

# Viterbi Algorithm Implementation
def viterbi(y, A, B, Pi=None):
    K = A.shape[0]
    Pi = Pi if Pi is not None else np.full(K, 1 / K)
    T = len(y)
    T1 = np.empty((K, T), 'd')
    T2 = np.empty((K, T), 'B')

    T1[:, 0] = Pi * B[:, y[0]]
    T2[:, 0] = 0

    for i in range(1, T):
        T1[:, i] = np.max(T1[:, i - 1] * A.T * B[np.newaxis, :, y[i]].T, 1)
        T2[:, i] = np.argmax(T1[:, i - 1] * A.T, 1)

    x = np.empty(T, 'B')
    x[-1] = np.argmax(T1[:, T - 1])

    for i in reversed(range(1, T)):
        x[i - 1] = T2[x[i], i]
    
    return x, T1, T2

# Observed sequence
obs_seq = np.array([0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0])

# State transition probabilities matrix A
A = np.array([[0.6, 0.4], 
              [0.4, 0.6]])

# Emission probabilities matrix B
B = np.array([[0.5, 0.5], 
              [0.8, 0.2]])

# Initial probabilities
Pi = np.array([0.5, 0.5])

# Using Viterbi algorithm to decode the sequence
x, T1, T2 = viterbi(obs_seq, A, B, Pi)

# Create figure and axis for the traceback visualization
fig, ax = plt.subplots(figsize=(14, 4))

# Flipped states for labeling
flipped_states = ['Loaded', 'Fair']

# Loop through each state
for i, state in enumerate(flipped_states):
    plt.plot([0, len(T2[0])-1], [i, i], 'k--', linewidth=0.5)
    for t in range(1, len(T2[0])):
        prev_state = 1 - T2[1 - i, t]
        plt.arrow(t-1, prev_state, 1, i-prev_state, head_width=0.1, head_length=0.1, fc='k', ec='k')

# Annotations and labels
plt.yticks([0, 1], flipped_states)
plt.xticks(np.arange(0, len(T2[0])), np.arange(0, len(T2[0])))
plt.xlabel('Time step')
plt.ylabel('State')
plt.title('Viterbi Traceback')
plt.grid(True)

plt.show()
