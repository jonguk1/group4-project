package com.lend.shareservice.web.board.boardexception.validator;

import com.lend.shareservice.web.board.boardexception.validator.FutureDateConstraint;
import com.lend.shareservice.web.board.dto.PostRegistrationDTO;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.time.LocalDate;

public class FutureDateValidator implements ConstraintValidator<FutureDateConstraint, Object> {

    @Override
    public void initialize(FutureDateConstraint constraintAnnotation) {
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        if (value instanceof PostRegistrationDTO) {
            PostRegistrationDTO postRegistrationDTO = (PostRegistrationDTO) value;
            LocalDate returnDate = postRegistrationDTO.getReturnDate();
            LocalDate deadline = postRegistrationDTO.getDeadline();
            if (returnDate != null && deadline != null) {
                return returnDate.isAfter(deadline);
            }
        }
        return true; // if either date is null, assume it's valid to leave checking to @NotNull or other validators
    }
}
