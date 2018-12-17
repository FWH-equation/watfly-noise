function signal = removeNoise(combined, noise, ignoreLowSNR=false)
	% removeNoise 	Remove noise from a signal
	%	signal = removeNoise(combined, noise) removes noise from combined,
	%	given both in dB

	% If combined < 5 dB louder than noise (SNR too low)
	% Requires both frequency vectors to be identical.
	if !ignoreLowSNR && any(combined - noise < 5)
		error("error: SNR too low. Combined signal and noise should be at least 5 dB greater than noise. To ignore this error, set ignoreLowSNR to true.");
	end

	if combined(:, 1) ~= noise(:, 1)
		error("error: Frequency vectors do not match.")
	end

	% Remove noise level from signal
	signal(:, 1) = combined(:, 1);
	signal(:, 2) = 10 .* log10(10.^(combined(:, 2) ./ 10) - 10.^(noise(:, 2) ./ 10));
end